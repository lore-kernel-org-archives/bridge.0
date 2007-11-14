Message-ID: <473B180D.9000600@cs.wisc.edu>
Date: Wed, 14 Nov 2007 09:45:17 -0600
From: Vivek Shrivastava <viveks@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] NFS over bridged interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
     I am running NFS over my soekris boxes, with eth0 as the primary 
wired interface (that gets dhcp ip address from the server and loads the 
entire NFS filesystem). Now I want to bridge traffic from (some traffic) 
eth0 to eth1 (another interface). But as soon as I add eth0 to the 
bridge, the box stops responding.  I have waited more than 30 sec (the 
default bridging fwd delay), but still see no response. I am a new to 
this community so I am not sure if this has been already discussed. Any 
help will be greatly appreciated.

Thanks
Vivek
