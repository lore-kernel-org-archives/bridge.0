Message-ID: <4B51A948.7070001@pandora.be>
Date: Sat, 16 Jan 2010 12:55:52 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <a573cc521001160029m1ec3f80s51f829993efa3049@mail.gmail.com>
In-Reply-To: <a573cc521001160029m1ec3f80s51f829993efa3049@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] dhcp thru bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leo Liang <lxsure@gmail.com>
Cc: bridge@lists.linux-foundation.org

Leo Liang schreef:
> Hi list,
>
>         i'm trying to setup a bridge on my Linux box, the situation is like
> below,
>
>         windows pc< -----------> eth0 [linux box] eth1
> <--------------------->DHCP server
>
>         i create a bridge on linux with eth0 and eth1 and i can get ip
> address from DHCP server for bridge
>         but i can't get ip address on my windows pc which connect to eth0 of
> Linux from DHCP server,
>
>         sorry for my poor network knowledge, i've been google around but
> cannot find the solution,
>         can any one give me some advice?
>
>   
Your bridge is probably not up, try 'ifconfig br0 up'. If that doesn't
do it, post the commands you use to set up the bridge.

Bart

-- 
Bart De Schuymer
www.artinalgorithms.be

