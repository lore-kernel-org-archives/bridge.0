Message-ID: <AD59566A9D83864F871AE2E5250306400506FB@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] problems with setpathcost feature
Date: Thu, 31 Jul 2003 08:27:18 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: "'jack@newdream.net'" <jack@newdream.net>
Cc: "'bridge@osdl.org'" <bridge@osdl.org>

Jack, when your problem occurs, does brctl report that the spanning tree
algorithm has blocked ports with pathcost 1 in favor of ports with pathcost
300?

> -----Original Message-----
> From: Jack Culpepper [mailto:jack@newdream.net] 
> Sent: Monday, July 21, 2003 5:29 PM
> To: bridge@math.leidenuniv.nl
> Subject: [Bridge] problems with setpathcost feature
> 
> 
> Hi Folks,
> 
> I have been using the bridging code to build out a small 
> wireless network
> with five nodes.  I am not sure if anyone on this list is 
> familiar with
> OpenAP (small linux dist for running on x86-based AP 
> stations) or the HostAP
> driver (wireless driver for Prism2 chipset), but that's what 
> I'm using.  The
> nodes in the network are "loosely" connected -- that is, the number of
> connections each node has varies from about 1-4.  I am using 
> STP to remove
> loops.  However, sometimes this results in STP "settling" on 
> using links that
> have low signal strengths.  This makes the performance of the 
> network drop,
> and thus I would like to take signal strength into account 
> via pathcosts.
> Eventually, I will be automatically computing pathcosts by 
> using some formula
> that involves the inverse of the signal strength (high signal 
> strength => low
> path cost).  However, as a quick test to make sure the 
> pathcost stuff was
> going to work like I want it to, I tried to manually impose 
> my own beliefs
> about which links should be used by simply setting them to 
> have pathcost 1,
> and all other links to pathcost 300.  To my disappointment, 
> this did not work.
> I know it didn't, because I am using the patch I just 
> submitted to discover
> the actual path my packets are following.  Has anyone on the list used
> pathcosts successfully?  Is there a trick to doing it besides simply
> 'brctl setpathcost br0 wlan0wds0 1'?  Does anyone have any 
> reason to believe
> the pathcost code does or does not work?  Thanks very much,
> 
> Jack
> 
> _______________________________________________
> Bridge mailing list
> Bridge@math.leidenuniv.nl
> http://www.math.leidenuniv.nl/mailman/listinfo/bridge
> 
