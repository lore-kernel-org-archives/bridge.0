Message-ID: <403FFECA.7050407@cox.net>
Date: Fri, 27 Feb 2004 19:36:58 -0700
From: Greg Morgan <drkludge@cox.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridging with kernel-2.6
References: <DBAC6BAF12D1D64289EC75515BD86577CA653C@exch101>
In-Reply-To: <DBAC6BAF12D1D64289EC75515BD86577CA653C@exch101>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Wouter Coppens <wouter.coppens@dedigate.com>
Cc: bridge@osdl.org

Wouter Coppens wrote:
> Hey,
> 
> Has anybody got bridging working with kernel-2.6?
> Are their things that need special attention?
> 
> I have read about the iptables physdev match module for 2.6. Is it required to get the bridge up and running?

I thought you had to have the ebtables patch applied before the bridging 
patch.  However, with ebtables being in the 2.5 and above kernels, I've 
lost track of the order of the patches these days.  A quick look at 
http://bridge.sourceforge.net/devel.html shows this "The code is updated 
as part of the current kernels available at kernel.org."  A link to 
ebtables is on the same page.  Are you experiencing some sort of problem?

Greg

