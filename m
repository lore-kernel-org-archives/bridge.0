Message-ID: <fd54385205081520403350f16a@mail.gmail.com>
Date: Tue, 16 Aug 2005 11:40:40 +0800
From: Steven Zhang <zhangseven@gmail.com>
Subject: [BRIDGE]A basic question: what's the relationship of the Rx/Tx
	packets count between the bridge and its enslaved NIC.
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have a bridge br0, it enslaves two NICs: eth0 and eth1. 
By using "cat /proc/net/dev ", i can see the Rx/Tx packets and bytes
through each interface. just like this:

[* time tick 1 *]

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed
multicast|bytes    packets errs drop fifo colls carrier compressed
    lo: 3926521   14121    0    0    0     0          0         0 
3926521   14121    0    0    0     0       0          0
  eth0: 7255431   37878    0    0    0     0          0         0
12869195   26229    0    0    0     0       0          0
  eth1:12172910   25800    3    3    0     3          0         0 
7849528   38567   72    0    0     5      77          0
   br0: 3035036   17478    0    0    0     0          0         0 
2950728   12908    0    0    0     0       0          0
 
[* time tick 2 *]

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed
multicast|bytes    packets errs drop fifo colls carrier compressed
    lo: 4020580   14734    0    0    0     0          0         0 
4020580   14734    0    0    0     0       0          0
  eth0: 7780868   41663    0    0    0     0          0         0
17450012   30518    0    0    0     0       0          0
  eth1:16759363   30073    3    3    0     3          0         0 
8375862   42391   72    0    0     5      77          0
   br0: 3086377   17819    0    0    0     0          0         0 
2986052   13185    0    0    0     0       0          0

[* the delta value *]

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed
multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:   94059     613    0    0    0     0          0         0   
94059     613    0    0    0     0       0          0
  eth0:  525437    3785    0    0    0     0          0         0 
4580817    4289    0    0    0     0       0          0
  eth1: 4586453    4273    0    0    0     0          0         0  
526334    3824    0    0    0     0       0          0
   br0:   51341     341    0    0    0     0          0         0   
35324     277    0    0    0     0       0          0

I wonder the meaning of the value of the br0,  it's Rx/Tx packets is
less than both eth0 and eth1.
what's the relationship of the values between bridge and it's enslaved NIC?

Thanks for your comments on this.

