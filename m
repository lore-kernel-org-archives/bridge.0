Subject: Re: [Bridge] Strange problem, please help
From: Jaime Nebrera <jnebrera@eneotecnologia.com>
In-Reply-To: <20050531092253.6b0797dd@dxpl.pdx.osdl.net>
References: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
	<1117523207.32760.84.camel@buttercup>
	<20050531092253.6b0797dd@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 31 May 2005 18:41:25 +0200
Message-Id: <1117557685.9462.34.camel@buttercup>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Ryan McConigley <ryan@csse.uwa.edu.au>, bridge@lists.osdl.org

  Hi,

> If you use the sk98lin driver it wants to do it's own spanning tree type
> failover so it multicasts STP packets all the time.

  Ok, I will ask my teammate

> You need to somehow figure out what those packets are (ethereal, tcpdump, ...)
> and go from there.

  They were HSRP packages going to IP multicast address 224.0.0.1 or
224.0.0.2 cant recall from the real IP of the two routers and going to
port 1985. These were clearly HSRP related packages.

> >   Regarding this point, we are using the same software solution with a
> > much cheaper box (Via 1Ghz, 4x Realtek 100 Ethernets) working as a
> > bridge and have been able to mange more than 20Mbps without a problem.
> > The difference is they dont have that HSRP set up.
> 
> You need to use a driver with NAPI or the interrupt per packet overhead
> will swamp the box.

  Yes, we are using NAPI with those Intel (100Mbps) and Marvel (GE).
Also, we discovered there is a port to Realtek with NAPI support for
kernel 2.4.x but we are just evaluating that and we are just trying to
figure if we are loading and using it right
(ftp://ftp.ovh.net/made-in-ovh/kernel/) Do you know how to know if its
using it or not? Yes, I know Realtek is not a pro driver, but this is
for an embedded system and cant be replaced.

  Regards

-- 
Jaime Nebrera - jnebrera@eneotecnologia.com
Consultor TI - ENEO Tecnologia SL
Telf.- 95 455 40 62 - 619 04 55 18

