Return-Path: <kenner@gnat.com>
Date: Thu, 17 Nov 2011 22:11:08 EST
Message-Id: <20111118031109.D805433C79@vlsi1.gnat.com>
From: kenner@gnat.com (Richard Kenner)
Subject: [Bridge] More on bridge/netfilter issue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a followup on the email I sent yesterday.  I'm still trying to
determine why no ip_conntrack entries are made and not making
much progress.  conntrack -E shows no activity and conntrack -S shows:

entries                 0       
searched                0       
found                   0       
new                     0       
invalid                 0       
ignore                  179445  
delete                  0       
delete_list             0       
insert                  0       
insert_failed           0       
drop                    0       
early_drop              0       
icmp_error              0       
expect_new              0       
expect_create           0       
expect_delete           0       
search_restart          0  

I'm running out of ideas.  Does anybody have any suggestions?

