Date: Wed, 23 Jun 2004 10:10:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge basic doubt
Message-Id: <20040623101019.0ac77a2d@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040623135501.5250.qmail@web21401.mail.yahoo.com>
References: <20040623135501.5250.qmail@web21401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Pattrick M <voice_ccna@yahoo.com>
Cc: bridge@lists.osdl.org

On Wed, 23 Jun 2004 06:55:01 -0700 (PDT)
Pattrick M <voice_ccna@yahoo.com> wrote:

> Hi,
>  
> I am very new to linux, sorry if my doubt is not valid, or i m asking some nonsense question..
>  
> Actually i want to use Linux as bridge. My setup is :
>  
> Setup 1) i have two bridge (dlink) with 1 port connected to 1-1 windows PCs.I have configured  ip addresses of both PC to same subnet.Now both the Pc are in same subnet and two bridges which are connected, so both r pinging to each other.
>  
> Setup 2) Instead of two bridges i want to use Linux PC with 2 interfaces. So i made one bridge using brctl command and added one interface to that bridge and made it up similarly for another interface. So now i have one Pc connected to one bridge and another connected to another bridge. Pc ip addresses are same , the problem is now they are not pinging to each other. why? I can make one bridge and add both the interfaces but i want to use two bridges so i made two, but it shouldn't change the behaviour.
>  
> i m planning to do my project in Linux so it'll really help me understand the basic difference, so pls let me know wht is wrong.


Remember that bridging happens at the Ethernet (link) level, and IP is not involved.
The typical diagram of bridging is:


                      +---------------+
                      | Host B        |
                      |               |
                      |   10.0.0.1    | 
                      +-------|-------+          Host A          Host C
                      |      br0      |         10.0.0.2        10.0.0.3
 (  External )        |               |            |              |
(   Network   ) ------| eth0     eth1 |------------+--------------+
 (  10.0.0.X )        |    bridge     |
                      +---------------+



















