Date: Mon, 30 Jul 2007 16:30:39 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Message-ID: <alpine.DEB.0.99.0707301607010.32557@callisto.moose.malc.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=UTF-8
Subject: [Bridge] brctl uses incorrect sysfs path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I noticed that brctl (or more accurately, libbridge) is using the wrong path 
when doing various lookups in sysfs: e.g. /sys/class/net/brXXX/stp_state 
when it should use /sys/class/net/brXXX/bridge/stp_state.  This doesn't 
cause any problems on most systems as it falls back to the ioctl when the 
sysfs attempt fails; however the ioctl method is apparently deprecated.  I 
believe the following patch fixes this:


diff --git a/libbridge/libbridge_devif.c b/libbridge/libbridge_devif.c
index 1decc28..65ea79a 100644
--- a/libbridge/libbridge_devif.c
+++ b/libbridge/libbridge_devif.c
@@ -282,7 +282,7 @@ static int br_set(const char *bridge, const char *name,
         char path[SYSFS_PATH_MAX];
         FILE *f;

-       snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/%s", bridge, name);
+       snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/bridge/%s", bridge, name);

         f = fopen(path, "w");
         if (f) {
diff --git a/libbridge/libbridge_init.c b/libbridge/libbridge_init.c
index e2eab77..f31addc 100644
--- a/libbridge/libbridge_init.c
+++ b/libbridge/libbridge_init.c
@@ -185,13 +185,18 @@ int br_foreach_port(const char *brname,
         int i, count;
         struct dirent **namelist;
         char path[SYSFS_PATH_MAX];
+       struct stat st;

-       snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/brport", brname);
+       snprintf(path, SYSFS_PATH_MAX, SYSFS_CLASS_NET "%s/brif", brname);
         count = scandir(path, &namelist, 0, alphasort);
         if (count < 0)
                 return old_foreach_port(brname, iterator, arg);

         for (i = 0; i < count; i++) {
+               if (stat(namelist[i]->d_name, &st) == -1)
+                       continue;
+               if (!S_ISLNK(st.st_mode))
+                       continue;
                 if (iterator(brname, namelist[i]->d_name, arg))
                         break;
         }


(Please CC me on any replies as I am not subscribed to this mailing list.)

Best wishes,

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

