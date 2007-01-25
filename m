Date: Thu, 25 Jan 2007 11:09:18 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070125110918.6531e49e@freekitty>
In-Reply-To: <7350AD3A-96AF-46D6-AEFF-9B855A993974@mpsnet.net.mx>
References: <969A8B08-19EE-445B-AAFB-2A9D8D3D5CE7@mpsnet.net.mx>
	<20070125104604.613432d4@freekitty>
	<7350AD3A-96AF-46D6-AEFF-9B855A993974@mpsnet.net.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] problem bridging
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Omar Armas <oarmas@mpsnet.net.mx>
Cc: bridge@osdl.org

On Thu, 25 Jan 2007 13:08:23 -0600
Omar Armas <oarmas@mpsnet.net.mx> wrote:

> >
> > iptables FORWARD rules apply to routing not bridging
> >
> > See:
> > 	http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html#section6
> 
> 
> I recompiled with kernel 2.6.19, included ebtables modules and now it  
> is working, I can filter with iptables and the FORWARD chain.
> I just want to confirm, was that the correct way to do it? Would have  
> it worked if I had patched 2.4 with ebtables?
> 

Yes. if you don't have ebtables then the bridge does no filtering
> 


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
