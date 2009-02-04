From: Bernhard Weirich <bernhard.weirich@riedel.net>
In-Reply-To: <1233680629.6415.12.camel@hactar.vie.riedel.net>
References: <1233680629.6415.12.camel@hactar.vie.riedel.net>
Content-Type: text/plain
Date: Wed, 4 Feb 2009 12:56:17 +0100
Message-ID: <1233748577.6465.7.camel@hactar.vie.riedel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP problem after ifupdown
Reply-To: bernhard.weirich@riedel.net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I have fixed the problem for myself by adding some code to
bridge_track.c
Here is the patch...

Signed-off-by: Bernhard Weririch <bernhard.weirich@riedel.net>
--- rstp-09-02/./bridge_track.c	2009-02-04 12:12:03.000000000 +0100
+++ rstp-09/./bridge_track.c 2009-02-04 11:59:48.000000000 +0100
@@ -72,6 +72,7 @@
 	/* If port */
 	int speed;
 	int duplex;
+	__u8 state;
 	struct ifdata *master;
 	struct ifdata *port_next;
 	/* STP port index */
@@ -403,12 +404,20 @@
 void set_br_up(struct ifdata *br, int up)
 {
 	int stp_up = stp_enabled(br);
-	INFO("%s was %s stp was %s", br->name,up ? "up" : "down", br->stp_up ?
"up" : "down");
+	INFO("%s was %s stp was %s", br->name,br->up ? "up" : "down",
br->stp_up ? "up" : "down");
 	INFO("Set bridge %s %s stp %s" , br->name,
 	     up ? "up" : "down", stp_up ? "up" : "down");
 
-	if (up != br->up)
+	if (up != br->up) {
 		br->up = up;
+		if (br->up && br->stp_up && stp_up) {
+			struct ifdata *port = br->port_list;
+			for (port = br->port_list; port; port = port->next) {
+				if (port->up) 
+					bridge_set_state(port->if_index, port->state);
+			}
+		}
+	}
 	
 	if (br->stp_up != stp_up) {
 		if (stp_up)
@@ -491,8 +500,10 @@
 			return -1;
 		}
 		/* Bridge must be up if we get such notifications */
-		if (!br->up)
-			set_br_up(br, 1);
+		/* bwe: in fact, the bridge gets the notifications even when down
+		 * therefore commented out */
+		//if (!br->up)
+		//	set_br_up(br, 1);
 	}
 
 	struct ifdata *ifc = find_if(if_index);
@@ -742,8 +753,10 @@
 		fprintf(stderr, "set_port_state: Unexpected state %d\n", state);
 		return -1;
 	}
-	if (port->up)
+	if (port->up) {
+		port->state = br_state;
 		bridge_set_state(port->if_index, br_state);
+	}
 	return 0;
 }
 

