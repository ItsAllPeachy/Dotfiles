#include <gtk/gtk.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SSIDS 100
#define MAX_LEN 256

/* Wifi Imports */




static void print_hello (GtkWidget *widget, gpointer data){
  g_print ("Hello World");
}
static void find_networks(char ssids[][MAX_LEN]){
  FILE *fp = popen("nmcli -t -f SSID dev wifi list","r"); 
  if (fp == NULL) return -1;

  int count = 0; 
  while (fgets(ssids[count], MAX_LEN, fp) != NULL && count < MAX_SSIDS) {
    ssids[count][strcspn(ssids[count], "\n")] = 0;
      if (strlen(ssids[count]) > 0)
        count++;
  }
  pclose(fp); 
  return count; 



}



static void activate (GtkApplication *app, gpointer user_data){
  GtkWidget *window;
  GtkWidget *button;
  window = gtk_application_window_new(app);
  gtk_window_set_title (GTK_WINDOW (window), "window1");
  gtk_window_set_default_size(GTK_WINDOW (window), 200, 200); 
  button = gtk_button_new_with_label ("Hello World");
  g_signal_connect (button, "clicked", G_CALLBACK (print_hello), NULL);
  gtk_window_set_child (GTK_WINDOW (window), button);
  gtk_window_present (GTK_WINDOW(window));
}

int main (int argc, char **argv){
  char ssids[MAX_SSIDS][MAX_LEN];
  int num = get_wifi_ssids(ssids);

  for (int i = 0; i < num; i++)
    printf("SSID %d: %s\n", i + 1, ssids[i]); 
  return 0; 



  GtkApplication *app;
  int status;
  app = gtk_application_new("org.gtk.example", G_APPLICATION_DEFAULT_FLAGS);
  g_signal_connect(app, "activate", G_CALLBACK(activate), NULL); 
  status = g_application_run (G_APPLICATION (app), argc, argv); 
  g_object_unref(app);
  return status;
}
