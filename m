Date: Tue, 19 Apr 2005 10:54:20 +1000
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Unexpected behaviour
Message-ID: <20050419105420.22fcc152@localhost.localdomain>
In-Reply-To: <5.2.0.9.1.20050418141522.03375db0@mailhost.csse.uwa.edu.au>
References: <5.2.0.9.1.20050418141522.03375db0@mailhost.csse.uwa.edu.au>
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
To: Ryan McConigley <ryan@csse.uwa.edu.au>
Cc: bridge@lists.osdl.org

On Mon, 18 Apr 2005 14:40:57 +0800
Ryan McConigley <ryan@csse.uwa.edu.au> wrote:

> 
> 	Hi, I've set up a bridge using the 2.6.11.6 kernel.  The machine is 
> running Debian testing with three NICs in it.  eth0 is a standard 100Mb 
> Intel NIC, eth1 and eth2 are both Intel gigabit cards using the e1000 driver.
> 
> 	I tested everything at 100Mb and it worked fine.  I moved the machine into 
> production, eth1 plugging into a dumb 100Mb D-link switch, eth2 plugging 
> into a shiney new Cisco 2950.
> 
> 	eth2 connects fine, giving me messages such as:
> Apr 18 13:58:39 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Down
> Apr 18 13:58:56 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Up 100 Mbps Full Duplex
> Apr 18 13:58:56 portcullis kernel: br0: port 2(eth2) entering learning state
> Apr 18 13:59:11 portcullis kernel: br0: topology change detected, propagating
> Apr 18 13:59:11 portcullis kernel: br0: port 2(eth2) entering forwarding state
> 
> 	eth1 however is a different story.  If I plugged that into the D-Link it 
> would come up for a few seconds, then down again, then up and just cycle 
> between being up and down.  Example:
> 
> Apr 18 13:58:26 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Down
> Apr 18 13:58:26 portcullis kernel: br0: port 2(eth2) entering disabled state
> Apr 18 13:58:27 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Up 100 Mbps Full Duplex
> Apr 18 13:58:27 portcullis kernel: br0: port 2(eth2) entering learning state
> Apr 18 13:58:27 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Down
> Apr 18 13:58:28 portcullis kernel: br0: port 2(eth2) entering disabled state
> Apr 18 13:58:29 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Up 100 Mbps Full Duplex
> Apr 18 13:58:29 portcullis kernel: br0: port 2(eth2) entering learning state
> Apr 18 13:58:29 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Down
> Apr 18 13:58:30 portcullis kernel: br0: port 2(eth2) entering disabled state
> Apr 18 13:58:32 portcullis kernel: e1000: eth2: e1000_watchdog: NIC Link is 
> Up 100 Mbps Full Duplex
> Apr 18 13:58:32 portcullis kernel: br0: port 2(eth2) entering learning state
> 
> 	I do have it running now by plugging it into a gigabit switch where it 
> connects at 1G, then plugging the gig switch into the D-link, not an ideal 
> solution, but one that appears to be working ok.
> 
> 	I'm curious if anyone knows why this is happening.  Its a first for me, 
> but this also is the first bridge I've made which features gigabit 
> cards.  Interestingly if I swap over eth1 and eth2 (so eth1 goes into the 
> Cisco and eth2 goes to the D-link) the same flipflop state occurs.
> 

The bridge code (in 2.6) responds to carrier up/down transistions from the
network device. This is a feature so that if there are multiple paths, the alternate
link will be used if cable is pulled or switch dies. It looks like the you have an
problem between the network interface and the switch. Something it causing it
like failed autonegotiation.
