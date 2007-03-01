Date: Thu, 1 Mar 2007 10:48:47 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070301104847.0e589b82@freekitty>
In-Reply-To: <000101c75c29$b4ecc9a0$988086c9@sam>
References: <000101c75c29$b4ecc9a0$988086c9@sam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge IP not answering
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Fernando Rodriguez <frod@aitelecom.net>
Cc: bridge@lists.osdl.org

On Thu, 1 Mar 2007 11:47:40 -0600
"Fernando Rodriguez" <frod@aitelecom.net> wrote:

> Hello, 
> 
> I have set up a bridge with the following script that starts after the
> network interfaces are started
> 
> BRIDGENAME="BRQ"
> GATEWAY="192.168.0.1"
> BRIDGE_IP="192.168.0.122"
> BRIDGE_NETMASK="255.255.255.0"
> STP_ON="yes"
> STP_PRIO="1"
> RETVAL=0
> 
> start() {
>         echo "Starting service bridge"
>        ifconfig eth2 promisc up
>         ifconfig eth3 promisc up

You don't need to do this (set promisc mode). And it can
cause more load.

>         brctl addbr $BRIDGENAME  ||  return=$rc_failed
>         brctl addif $BRIDGENAME eth2  ||  return=$rc_failed
>         brctl addif $BRIDGENAME eth3  ||  return=$rc_failed
>         ifconfig eth2 0.0.0.0  ||  return=$rc_failed
>         ifconfig eth3 0.0.0.0  ||  return=$rc_failed
>         brctl sethello $BRIDGENAME 1  ||  return=$rc_failed
>         brctl setmaxage $BRIDGENAME 4  ||  return=$rc_failed
>         brctl setfd $BRIDGENAME 4  ||  return=$rc_failed
>         brctl stp $BRIDGENAME $STP_ON
>         brctl setbridgeprio $BRIDGENAME $STP_PRIO
>         ifconfig $BRIDGENAME $BRIDGE_IP netmask $BRIDGE_NETMASK up

>         ip route flush cache
>         ip route add default via $GATEWAY

You may need to add 'dev $BRIDGENAME' to that

> 
> But the problem i have is that i am not able to contact the bridge on its IP
> 192.168.0.122 i am running Centos 4.4 on a 2.6.18 kernel, i have tested this
> setup on 3 different sets of network cards tg3, b44, via-rhine and in all of
> them i have the same results no connection, i know the bridge is working
> otherwise packets couldnt flow on the network, im using bridge utils 1.0.4-4

What is state of bridge? 
	brctl showstp $BRIDGENAME

Is it picking up the mac addresss?
	brctl showmacs $BRIDGENAME

> If any one knows what could be wrong??

Is bridge pseudo device receiving packets?
	ip -s -s link show $BRIDGENAME
 
> Or does any one has a script or an example on how they set up their bridge
> in order to be able to access it via its IP
> 


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
