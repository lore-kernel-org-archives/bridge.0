Date: Wed, 25 Aug 2004 00:10:21 +0200
From: Francois Ambrosini <fambrosini@nerim.fr>
Subject: Re: [Bridge] Encrypting Bridge?
Message-Id: <20040825001021.6b780366.fambrosini@nerim.fr>
In-Reply-To: <412B607E.6030109@joshua.raleigh.nc.us>
References: <1196.80.133.183.165.1093361732.squirrel@80.133.183.165>
	<412B607E.6030109@joshua.raleigh.nc.us>
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
To: Josh Wyatt <jdwyatt@joshua.raleigh.nc.us>
Cc: ML@bartschnet.de, bridge@lists.osdl.org

On Tue, 24 Aug 2004 11:36:30 -0400
Josh Wyatt <jdwyatt@joshua.raleigh.nc.us> wrote:

[snip]
> >>IMHO, and in addition to what Rene Bartsch said, providing an encrypted
> > 
> > tunnel at layer 2 can be really useful when it comes to bandwidth and/or
> > latency matters.
> > 
> 
> There is already a tool to do layer-2 bridging with encryption.  Check out vtun:
> 
> http://vtun.sourceforge.net/
> 
> I use it a great deal to do layer-2 bridging.  It works with the kernel tun/tap 
> driver and works very well.  It can use TCP or UDP as the transport, offers 
> compression, etc.  Key management is up to you, however.
> 
> Thanks,
> Josh
> 
> 

Hello Josh,

VTun certainly provides virtual interfaces which look like Ethernet or IP interfaces from the kernel point of view, but if you start from the physical medium, you will find a bunch of protocol layers before reaching the Ethernet or IP data sent respectively through the tap or tun (because of TCP or UDP used as transport). I was talking about direct encryption of the layer 2 payload as a solution to prevent all this protocol overhead.

Please note, I am not saying that using a tunneled solution is not a good choice. It is when one can sacrifice bandwidth or latency for security and useful functionalities (that's almost always the case).

I went through the patch against kernel 2.4.19-pre8 found on http://www.arnor.net/encryptingbridge/ : it actually takes care of the UDP payload only. No true Ethernet encryption as I though first. Having said that, I wonder if that kind of encryption is possible without breaking the Ethernet standard. For example, think of the Ethernet Type field for which a registered identifier would have to be provided.

Anyway, I misanderstood Rene Bartsch's query in the first place, as "encrypted bridge" made me think of "encrypted layer 2 payload". I like the later concept but I agree with Stephen that it has nothing to do with the bridging standard.

Regards,

Francois
