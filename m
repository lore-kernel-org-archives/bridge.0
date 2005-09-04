Message-ID: <20050904060038.67284.qmail@web34108.mail.mud.yahoo.com>
Date: Sat, 3 Sep 2005 23:00:38 -0700 (PDT)
From: Zoran s <s_zoran@yahoo.com>
Subject: Re: [Bridge] STP problem
In-Reply-To: <434f7cd7050902102561a0cc84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Daniel Gheorghica <gheodan@gmail.com>, Bridge@lists.osdl.org

Daniel,

I have couple of questions here to help to close on to
the cause of the problem.

Does it happen [ping stops working] in any case (when
ANY of the links fail)?

You might consider [both scenarios] setting only one
link to be tunnel between your LANs, and see what then
will happen with ping, this test scenarios might help:
LAN1 -- BRIDGE1 -- Wireless Link -- BRIDGE2 -- LAN2
or
LAN1 -- BRIDGE1 -- TINC vpn tunnel -- BRIDGE2 -- LAN2

Regards,
Zoran

--- Daniel Gheorghica <gheodan@gmail.com> wrote:

> Hi all, 
>  I have to use STP function between too bridges. The
> network topology are:
>  /--------------\ / ------ Wireless Link ----\
> /--------------------\
> |==LAN1==| ---- | BRIDGE 1| | BRIDGE 2| -----|
> ===LAN 2=== | 
> \---------------/ \ -----TINC vpn tunnel ------/
> \---------------------/
>  When one of link failed the ping from one to other
> site stop to works. 
> I use bridge-utils-1.0.6 and tinc-1.0.4 
>  I wait any suggestion about this
>  Daniel 
>   The bridege setup script is: 
>   
> #! /bin/bash
> 
> PATH=$PATH:/usr/local/sbin:/sbin
> BR=br0
> IP="172.16.3.223 <http://172.16.3.223>"
> MASK="255.255.252.0 <http://255.255.252.0>"
> BROADCAST="172.16.3.255 <http://172.16.3.255>"
> 
> return=$rc_done
> case "$1" in
> 
> start)
> echo "Starting service bridge $BR"
> tincd -n vpn
> brctl addbr $BR
> brctl setbridgeprio $BR 0 || return=$rc_failed
> brctl addif $BR eth0 || return=$rc_failed
> brctl addif $BR eth1 || return=$rc_failed
> brctl addif $BR vpn || return=$rc_failed
> ifconfig eth0 0.0.0.0 <http://0.0.0.0> ||
> return=$rc_failed
> ifconfig eth1 0.0.0.0 <http://0.0.0.0> ||
> return=$rc_failed
> ifconfig vpn 0.0.0.0 <http://0.0.0.0> ||
> return=$rc_failed
> brctl sethello $BR 1 || return=$rc_failed
> brctl setmaxage $BR 4 || return=$rc_failed
> brctl setpathcost $BR eth1 100 || return=$rc_failed
> 
> brctl setpathcost $BR vpn 100 || return=$rc_failed
> brctl setportprio $BR eth1 20 || return=$rc_failed
> brctl setportprio $BR vpn 20 || return=$rc_failed
> # brctl setageing $BR 20 || return=$rc_failed
> brctl setfd $BR 4 || return=$rc_failed
> brctl stp $BR on
> /sbin/ifconfig $BR inet $IP netmask $MASK broadcast
> $BROADCAST up
> echo -e "$return"
> ;;
> 
> stop)
> tincd -k -n vpn
> /sbin/ifconfig $BR down
> echo "Shutting down service bridge $BR"
> brctl delif $BR vpn || return=$rc_failed
> brctl delif $BR eth0 || return=$rc_failed
> brctl delif $BR eth1 || return=$rc_failed
> brctl delbr $BR || return=$rc_failed
> rmmod bridge || return=$rc_failed
> echo -e "$return"
> ;;
> 
> status)
> ifconfig $BR
> brctl showstp $BR
> brctl show
> ;;
> 
> restart)
> $0 stop && $0 start || return=$rc_failed
> ;;
> 
> *)
> 
> echo "Usage: $0 {start|stop|status|restart}"
> exit 1
> esac
> 
> test "$return" = "$rc_done" || exit 1
> exit 0



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
