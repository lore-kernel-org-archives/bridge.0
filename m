Subject: Re: [Bridge] Strange problem, please help
From: Jaime Nebrera <jnebrera@eneotecnologia.com>
In-Reply-To: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
References: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
Content-Type: text/plain
Date: Tue, 31 May 2005 09:06:47 +0200
Message-Id: <1117523207.32760.84.camel@buttercup>
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
To: Ryan McConigley <ryan@csse.uwa.edu.au>
Cc: bridge@lists.osdl.org

  Hi Ryan,

>          Just my $0.02 worth, no solutions I'm afraid, just an 
> observation.  The behavour you describe is virtually identical to the 
> behavour I had on the first bridge I constructed which was using tulip 
> network cards.  The system would work wonderfully in test, but put it in 
> situ on the network it would last a few minutes, then lock up with the CPU 
> maxed out.  We ended up changing the tulip cards to Intels which worked 
> perfectly.
> 
>          The weird thing was on their own, the tulip cards worked fine, but 
> couldn't handle a bridge config.  At the time folks suggested that it was a 
> combined interrupt/timing/buffering problem, but I didn't have the skills 
> or time to track it down.  From what you've said about the problem going 
> away when the other network ports are disabled, I wouldn't mind betting its 
> a related issue.  8 Gigabit ports would be a substantial number of 
> interrupts, so I wouldn't be surprised if you're starting to max out the 
> PCI bus, but I don't have any hard numbers to test that theory.

  IMHO I dont agree. We are using chipsets from Marvel, a well
stablished ones. Also, this might be a problem if the traffic was really
important, say 200Mbps or even 100Mbps, but this is not the case for
0,5Mbps. Even those cheap Realtek 100Mbps ethernets can sustain that
traffic as a bridge.

  The problem is WHY suddenly some traffic appears on ethernet ports
that are not in use (and why not in two others) and WHY this traffic
keeps accelerating until it reaches a speed the hardware wont support
(2400Mbps total) Of course when such traffic is reached the system blows
away, the point is, why that traffic appears?

  Regarding this point, we are using the same software solution with a
much cheaper box (Via 1Ghz, 4x Realtek 100 Ethernets) working as a
bridge and have been able to mange more than 20Mbps without a problem.
The difference is they dont have that HSRP set up.

  So it is related to HSRP or something related to IRQ as somebody has
suggested me on other email. The problem here is why this IRQ problem
didnt appear in our test environment (without HSRP) with more traffic
and open sessions than the client had?

  Still, thanks for your 2 cents :)

  Regards

-- 
Jaime Nebrera - jnebrera@eneotecnologia.com
Consultor TI - ENEO Tecnologia SL
Telf.- 95 455 40 62 - 619 04 55 18

