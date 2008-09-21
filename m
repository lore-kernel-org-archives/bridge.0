Message-ID: <48D6DF9D.10708@126.com>
Date: Mon, 22 Sep 2008 07:58:21 +0800
From: czj <linuxdemo@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 4 ports bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,
I work on a SOC based on AMCC/glacier based on PPC460GT. (
http://WWW.AMCC.com <http://micrel.com/page.do?page=product-info/sys_on_chip.jsp>)
This component has 4 network interfaces. 

Every one is connected to a PC.

eth0 =>192.168.1.11
eth1 => 192.168.1.22
eth2 => 192.168.1.33
eth3 => 192.168.1.44

I want to make a bridge with these 4 ports

#brctl addbr br0

#ifconfig br0 192.168.1.20 netmask 255.255.255.0

#ifconfig eth0 0.0.0.0 up

#ifconfig eth1 0.0.0.0 up

#ifconfig eth2 0.0.0.0 up

#ifconfig eth3 0.0.0.0 up

# brctl addif br0 eth0

# brctl addif br0 eth1

# brctl addif br0 eth2

# brctl addif br0 eth3

#brctl stp on

but my problem is that when I used the PC(which IP is 192.168.1.11/24) to ping other PCs,

the ping reply time from 192.168.1.22 was about 1000ms;
the ping reply time from 192.168.1.33 was about 0.2ms;
the ping reply time form 192.168.1.44 was about 300ms;

Why? and how to configure  the 4 ethernet-ports glacier board to be a bridge or switch correctly? thanks a lot.


Thanks,
Cheng Zijing


