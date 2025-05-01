import subprocess
import sys

def calculate_percentage(temp, min_temp=30, max_temp=100):
    if temp < min_temp:
        return 0
    elif temp > max_temp:
        return 100
    else:
        return int(((temp - min_temp) * 100) / (max_temp - min_temp))

def get_avg_temp_percent():
    result = subprocess.run(['sensors'], stdout=subprocess.PIPE, text=True)
    percentages = []

    for line in result.stdout.splitlines():
        if "Core" in line:
            temp_str = line.split()[2].strip('+°C')
            try:
                core_temp = float(temp_str)
                percentages.append(calculate_percentage(core_temp))
            except ValueError:
                continue

    if percentages:
        avg = sum(percentages) // len(percentages)
        return avg

def main():
    if len(sys.argv) < 2:
        sys.exit()

    if sys.argv[1] == "--temp":
        print(get_avg_temp_percent())
    elif sys.argv[1] == "--icon":
        temp = get_avg_temp_percent()
        if temp is not None:
            if temp > 80:
                print("")
            else:
                print("")

if __name__ == '__main__':
    main()