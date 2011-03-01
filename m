Message-ID: <4D6C878A.503@redpinesignals.com>
Date: Tue, 01 Mar 2011 11:13:38 +0530
From: PrameelaRani <prameelarani.g@redpinesignals.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge not puping more data in TCP
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
I have configured a bridge between ethernet and WLAN interfaces. This is 
the only bridge in my system. When we are transmitting udp traffic from 
ethernet machine to wlan machine, bridge is pumping enough packets but 
when we are doing TCP it is not pumping more data and hence we are 
getting less throughputs.
Here is the bridge script we are using presently.

brctl addbr bri0
ifconfig bri0 192.168.200.127 netmask 255.255.255.0
ifconfig bri0 up
brctl setfd bri0 1
brctl stp bri0 off
brctl addif bri0 eth0 ; /sbin/ifconfig eth0 up 0.0.0.0 ;
brctl addif bri0 vap0 ;#/sbin/ifconfig vap0 up 0.0.0.0 ;

Do I need to set any other options like setbridgeprio etc??. But I think 
this is useful if we have more than one bridge.

Thanks,
Prameela

