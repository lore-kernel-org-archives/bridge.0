From: "Fernando Rodriguez" <frod@aitelecom.net>
References: <E79DFBD205C0DD4996667AFAE29FFFB3150B40@DSO2E.ltp.trz.cz>
	<007101c75db8$973d4890$988086c9@sam>
Date: Sat, 3 Mar 2007 11:31:33 -0600
Message-ID: <007901c75db9$c95fcc20$988086c9@sam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <007101c75db8$973d4890$988086c9@sam>
Subject: Re: [Bridge] [Ebtables-user] Bridge IP not anwering
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ebtables-user-bounces@lists.sourceforge.net
Cc: bridge@lists.osdl.org

This is the output of the brctl commands

bridge name     bridge id               STP enabled     interfaces
BRQ             0001.0002b64103b1       yes             eth2
                                                        eth3


BRQ
 bridge id              0001.0002b64103b1
 designated root        0001.0002b64103b1
 root port                 0                    path cost                  0
 max age                   4.00                 bridge max age
4.00
 hello time                1.00                 bridge hello time
1.00
 forward delay             4.00                 bridge forward delay
4.00
 ageing time             300.01
 hello timer               0.25                 tcn timer
0.00
 topology change timer     0.00                 gc timer
0.08
 flags


eth2 (1)
 port id                8001                    state
forwarding
 designated root        0001.0002b64103b1       path cost                  4
 designated bridge      0001.0002b64103b1       message age timer
0.00
 designated port        8001                    forward delay timer
0.00
 designated cost           0                    hold timer
0.25
 flags                  CONFIG_PENDING 

eth3 (2)
 port id                8002                    state
forwarding
 designated root        0001.0002b64103b1       path cost                 19
 designated bridge      0001.0002b64103b1       message age timer
0.00
 designated port        8002                    forward delay timer
0.00
 designated cost           0                    hold timer
0.25
 flags                  CONFIG_PENDING 


Is the CONFIG_PENDING any kind of issue on the bridge??

I currently have no rules for iptables or ebtables is this the reazon of why
i cant ping or access the bridge via its ip?? 

-----Mensaje original-----
De: ebtables-user-bounces@lists.sourceforge.net
[mailto:ebtables-user-bounces@lists.sourceforge.net] En nombre de Turon Ivo
ing.
Enviado el: Jueves, 01 de Marzo de 2007 03:31 p.m.
Para: ebtables-user@lists.sourceforge.net
Asunto: Re: [Ebtables-user] Bridge IP not anwering

You didn't write anything about iptables setting.
This could be problem
what is your iptables setting ? Did you allow input and output for that ping
partner ?


-----Original Message-----
From: ebtables-user-bounces@lists.sourceforge.net
[mailto:ebtables-user-bounces@lists.sourceforge.net]On Behalf Of Fernando
Rodriguez
Sent: Thursday, March 01, 2007 10:03 PM
To: ebtables-user@lists.sourceforge.net
Subject: [Ebtables-user] Bridge IP not anwering


Hello, 

I have set up a bridge with the following script that starts after the
network interfaces are started

BRIDGENAME="BRQ"
GATEWAY="192.168.0.1"
BRIDGE_IP="192.168.0.122"
BRIDGE_NETMASK="255.255.255.0"
STP_ON="yes"
STP_PRIO="1"
RETVAL=0

start() {
        echo "Starting service bridge"
       ifconfig eth2 promisc up
        ifconfig eth3 promisc up
        brctl addbr $BRIDGENAME  ||  return=$rc_failed
        brctl addif $BRIDGENAME eth2  ||  return=$rc_failed
        brctl addif $BRIDGENAME eth3  ||  return=$rc_failed
        ifconfig eth2 0.0.0.0  ||  return=$rc_failed
        ifconfig eth3 0.0.0.0  ||  return=$rc_failed
        brctl sethello $BRIDGENAME 1  ||  return=$rc_failed
        brctl setmaxage $BRIDGENAME 4  ||  return=$rc_failed
        brctl setfd $BRIDGENAME 4  ||  return=$rc_failed
        brctl stp $BRIDGENAME $STP_ON
        brctl setbridgeprio $BRIDGENAME $STP_PRIO
        ifconfig $BRIDGENAME $BRIDGE_IP netmask $BRIDGE_NETMASK up

        ip route flush cache
        ip route add default via $GATEWAY

But the problem i have is that i am not able to contact the bridge on its IP
192.168.0.122 i am running Centos 4.4 on a 2.6.18 kernel, i have tested this
setup on 3 different sets of network cards tg3, b44, via-rhine and in all of
them i have the same results no connection, i know the bridge is working
otherwise packets couldnt flow on the network, im using bridge utils 1.0.4-4

If any one knows what could be wrong??

Or does any one has a script or an example on how they set up their bridge
in order to be able to access it via its IP?? Do i have to use ebtables to
achieve this??


Thanks


--
This message has been scanned for viruses and dangerous content by
MailScanner, and is believed to be clean.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Ebtables-user mailing list
Ebtables-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ebtables-user

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Ebtables-user mailing list
Ebtables-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ebtables-user

--
This message has been scanned for viruses and dangerous content by
MailScanner, and is believed to be clean.


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Ebtables-user mailing list
Ebtables-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ebtables-user


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

