Message-Id: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
Date: Mon, 30 May 2005 16:07:07 +0800
From: Ryan McConigley <ryan@csse.uwa.edu.au>
Subject: Re: [Bridge] Strange problem, please help
In-Reply-To: <1117437923.32764.9.camel@buttercup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

At 09:25 AM 30/05/2005 +0200, Jaime Nebrera wrote:
>   Hi all,

         <snip>

>   So, some questions:
>
>   1) Is this related to running as a bridge? Would this problem
>disappear if we used a pseudo bridge (proxy ARP)?
>
>   2) Can such a beast sustain 8 ethernets as a single bridge? Bear in
>mind they dont have gigabit traffic, they just use gigabit ethernets :)
>Whats the limit for a linux bridge? Would be better to break it into two
>bridges?

         Just my $0.02 worth, no solutions I'm afraid, just an 
observation.  The behavour you describe is virtually identical to the 
behavour I had on the first bridge I constructed which was using tulip 
network cards.  The system would work wonderfully in test, but put it in 
situ on the network it would last a few minutes, then lock up with the CPU 
maxed out.  We ended up changing the tulip cards to Intels which worked 
perfectly.

         The weird thing was on their own, the tulip cards worked fine, but 
couldn't handle a bridge config.  At the time folks suggested that it was a 
combined interrupt/timing/buffering problem, but I didn't have the skills 
or time to track it down.  From what you've said about the problem going 
away when the other network ports are disabled, I wouldn't mind betting its 
a related issue.  8 Gigabit ports would be a substantial number of 
interrupts, so I wouldn't be surprised if you're starting to max out the 
PCI bus, but I don't have any hard numbers to test that theory.

         Cheers,
                 Ryan.
--
           Ryan McConigley - Systems Administrator                  _.-,
      Computer Science   University of Western Australia        .--'  '-._
        Tel: (+61 8) 6488 7082 - Fax: (+61 8) 6488 1089       _/`-  _      '.
Ryan[@]csse.uwa.edu.au - http://www.csse.uwa.edu.au/~ryan  '----'._`.----. \
                                                                      `     \;
  "You're just jealous because the voices are talking to me"                ;_\



