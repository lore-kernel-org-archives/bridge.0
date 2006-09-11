Date: Mon, 11 Sep 2006 10:57:44 -0700
From: David Kimdon <david.kimdon@devicescape.com>
Message-ID: <20060911175744.GA3490@devicescape.com>
References: <20060911174928.GA3451@devicescape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911174928.GA3451@devicescape.com>
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Kimdon <david.kimdon@devicescape.com>
Cc: bridge@lists.osdl.org

Hi,

Here is the corresponding patch to brctl.

-David

Index: bridge-utils-1.1/brctl/brctl_cmd.c
===================================================================
--- bridge-utils-1.1.orig/brctl/brctl_cmd.c
+++ bridge-utils-1.1/brctl/brctl_cmd.c
@@ -390,6 +390,105 @@ static int br_cmd_showmacs(int argc, cha
 	return 0;
 }
 
+static int br_cmd_setuntagged(int argc, char*const* argv)
+{
+	int vlan_id, err;
+
+	if (!strcmp(argv[3], "none"))
+		vlan_id = 0;
+	else	if (sscanf(argv[3], "%i", &vlan_id) != 1 ||
+			vlan_id < 1 || vlan_id > 4094) {
+		fprintf(stderr, "vlan id must be 'none' or from 1 to 4094\n");
+		return 1;
+	}
+
+	if (!strcmp(argv[2], "local"))
+		err = br_set_port_untagged_vlan(argv[1], 0, vlan_id);
+	else
+		err = br_set_port_untagged_vlan(argv[1], argv[2], vlan_id);
+
+	if (err)
+		fprintf(stderr, "set untagged vlan failed: %s\n",
+			strerror(err));
+	return err != 0;
+}
+
+static int br_cmd_vlanfilter(char*const* argv, int (*func)(const char *, const char *, unsigned int))
+{
+	int vlan_id, err;
+
+	if (!strcmp(argv[3], "all"))
+		vlan_id = 0;
+	else	if (sscanf(argv[3], "%i", &vlan_id) != 1 ||
+			vlan_id < 1 || vlan_id > 4094) {
+		fprintf(stderr, "vlan id must be 'all' or from 1 to 4094\n");
+		return 1;
+	}
+
+	err = func(argv[1], strcmp(argv[2], "local")?argv[2]:0, vlan_id);
+	if (err)
+		fprintf(stderr, "set vlan filter failed: %s\n",
+			strerror(err));
+	return err != 0;
+}
+
+static int br_cmd_addvlan(int argc, char*const* argv)
+{
+	return br_cmd_vlanfilter(argv, br_add_vlan);
+}
+
+static int br_cmd_delvlan(int argc, char*const* argv)
+{
+	return br_cmd_vlanfilter(argv, br_del_vlan);
+}
+
+int show_port_vlan(const char *brname, const char *port,
+					   void *arg )
+{
+	int err, count = 0, i;
+	struct vlan_info v;
+
+	err = br_get_port_vlan_info(brname, port, &v);
+	if (err)
+		fprintf(stderr, "get single vlan failed: %s\n",
+			strerror(err));
+
+	printf("%s\t", port?port:brname);
+
+	if (v.untagged)
+		printf("%d\t\t", v.untagged);
+	else
+		printf("none\t\t");
+
+	for(i = 1; i < 4095; i++)
+		if (v.filter[i / 8] & (1 << (i & 7)))
+			count++;
+
+	if (count == 4094)
+		printf("all\n");
+	else if (count == 0)
+		printf("none\n");
+	else {
+		int first = 1;
+
+		for(i = 1; i < 4095; i++)
+			if (v.filter[i / 8] & (1 << (i & 7))) {
+				printf("%s%d", first?"":", ", i);
+				first = 0;
+			}
+		printf("\n");
+	}
+
+	return err != 0;
+}
+
+static int br_cmd_showvlans(int argc, char*const* argv)
+{
+	printf("Port\tUntagged vlan\tEnabled Vlans\n");
+	show_port_vlan(argv[1], 0, 0);
+	return br_foreach_port(argv[1], show_port_vlan, 0);
+}
+
 static const struct command commands[] = {
 	{ 1, "addbr", br_cmd_addbr, "<bridge>\t\tadd bridge" },
 	{ 1, "delbr", br_cmd_delbr, "<bridge>\t\tdelete bridge" },
@@ -418,6 +517,14 @@ static const struct command commands[] =
 	  "<bridge>\t\tshow bridge stp info"},
 	{ 2, "stp", br_cmd_stp,
 	  "<bridge> {on|off}\tturn stp on/off" },
+ 	{ 3, "setuntagged", br_cmd_setuntagged,
+ 	  "<bridge> <port>|local <vlan_id>|none\tset untagged vlan id" },
+ 	{ 3, "addvlan", br_cmd_addvlan,
+ 	  "<bridge> <port>|local <vlan_id>|all\tenable specific or all vlans" },
+ 	{ 3, "delvlan", br_cmd_delvlan,
+ 	  "<bridge> <port>|local <vlan_id>|all\tdisable specific or all vlans" },
+ 	{ 1, "showvlans", br_cmd_showvlans,
+ 	  "<bridge>\t\tshow vlan info"},
 };
 
 const struct command *command_lookup(const char *cmd)
Index: bridge-utils-1.1/libbridge/libbridge.h
===================================================================
--- bridge-utils-1.1.orig/libbridge/libbridge.h
+++ bridge-utils-1.1/libbridge/libbridge.h
@@ -76,6 +76,12 @@ struct port_info
 	struct timeval hold_timer_value;
 };
 
+struct vlan_info
+{
+	unsigned untagged;
+	unsigned char filter[4096/8];
+};
+
 extern int br_init(void);
 extern int br_refresh(void);
 extern void br_shutdown(void);
@@ -107,4 +113,13 @@ extern int br_set_path_cost(const char *
 			    int path_cost);
 extern int br_read_fdb(const char *br, struct fdb_entry *fdbs, 
 		       unsigned long skip, int num);
+
+int br_set_port_untagged_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id);
+int br_add_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id);
+int br_del_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id);
+int br_get_port_vlan_info(const char *brname, const char *port,
+		     struct vlan_info *info);
 #endif
Index: bridge-utils-1.1/libbridge/libbridge_devif.c
===================================================================
--- bridge-utils-1.1.orig/libbridge/libbridge_devif.c
+++ bridge-utils-1.1/libbridge/libbridge_devif.c
@@ -506,3 +506,129 @@ int br_read_fdb(const char *bridge, stru
 	
 	return n;
 }
+
+static int br_dev_ioctl(const char *br_name, unsigned long cmd,
+	unsigned long arg0, unsigned long arg1, unsigned long arg2)
+{
+	int fd;
+	struct ifreq ifr;
+	unsigned long args[4];
+	int rv;
+
+	if ((fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
+		perror("socket[AF_INET,SOCK_STREAM]");
+		return -1;
+	}
+
+	args[0] = cmd;
+	args[1] = arg0;
+	args[2] = arg1;
+	args[3] = arg2;
+
+	strncpy(ifr.ifr_name, br_name, sizeof(ifr.ifr_name));
+	ifr.ifr_data = (__caddr_t) args;
+
+	rv = ioctl(fd, SIOCDEVPRIVATE, &ifr);
+
+	if (rv) {
+		perror("ioctl[SIOCDEVPRIVATE]");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
+int br_set_port_untagged_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id)
+{
+	int index;
+
+	if (port) {
+		index = get_portno(brname, port);
+		if (index < 1)
+			return errno;
+	} else
+		index = 0;
+
+	if (br_dev_ioctl(brname, BRCTL_SET_PORT_UNTAGGED_VLAN,
+		index, vlan_id, 0)) {
+		dprintf("can't set port %s(%d) untagged vlan %s\n",
+			brname, index, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+int br_add_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id)
+{
+	int index;
+
+	if (port) {
+		index = get_portno(brname, port);
+		if (index < 1)
+			return errno;
+	} else
+		index = 0;
+
+	if (br_dev_ioctl(brname, BRCTL_ADD_PORT_VLAN,
+		index, vlan_id, 0)) {
+		dprintf("can't add vlan %d on port %s(%d)  %s\n",
+			vlan_id, brname, index, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+int br_del_vlan(const char *brname, const char *port,
+		     unsigned int vlan_id)
+{
+	int index;
+
+	if (port) {
+		index = get_portno(brname, port);
+		if (index < 1)
+			return errno;
+	} else
+		index = 0;
+
+	if (br_dev_ioctl(brname, BRCTL_DEL_PORT_VLAN,
+		index, vlan_id, 0)) {
+		dprintf("can't delete vlan %d on port %s(%d)  %s\n",
+			vlan_id, brname, index, strerror(errno));
+		return errno;
+	}
+
+	return 0;
+}
+
+int br_get_port_vlan_info(const char *brname, const char *port,
+		     struct vlan_info *info)
+{
+	struct __vlan_info i;
+	int index = 0;
+
+	memset(info, 0, sizeof(*info));
+
+	if (port) {
+		index = get_portno(brname, port);
+		if (index < 1)
+			return errno;
+	} else
+		index = 0;
+
+	if (br_dev_ioctl(brname, BRCTL_GET_PORT_VLAN_INFO,
+		(unsigned long) &i, index, 0)) {
+		dprintf("old can't get port %s(%d) info %s\n",
+			brname, index, strerror(errno));
+		return errno;
+	}
+
+	info->untagged = i.untagged;
+	memcpy(&info->filter, &i.filter, 4096/8);
+	return 0;
+}
