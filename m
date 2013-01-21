Return-Path: <shmulik.ladkani@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	bh=EZjFEvgchjmLnlCxmeIFeiVhcQgOTEtgus9MkgM68l4=;
	b=eu/cVYX2IlTc6QlEKZAPJcEq18RZkK3cBoKuqSocFdwjLrmflb0yxqxiZNiZLKtIt5
	qkROmoN7Ru+KudDpHkEwb1eK4lbfDVgwpQD/mwIB5SXp/xjLOk0Z5AvGyZb6yL6RtFPQ
	Xrdalt+GBnaI8T4d5z4WSVbL0g8fjMrpLtuPGU4j23VnWLFzsBbwr6F8ZaP73g0Ir3Ae
	v4nrTcc9/DVVQArxJ/8Jau0q3gkLTX5xFGFZHsESFoswc0MVfUhUZCVCkRn9ARUhXzw/
	wA32t8x9JcGmeELUdjQYnivgEhKDNpB10AKDnxJY03JslzIaInG0N1ybYzXgnXpQrCjd
	lyvg==
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <20130121134534.78032a54.shmulik.ladkani@gmail.com>
In-Reply-To: <50FC9F03.5000102@redhat.com>
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-3-git-send-email-vyasevic@redhat.com>
	<CAHXqBFKg6Vp5=dprDYKON2LmshhX+nSPF7KRHiQmOS68PrQq-A@mail.gmail.com>
	<50FC307A.5090003@redhat.com>
	<20130120113825.759b4a58@nehalam.linuxnetplumber.net>
	<50FC9F03.5000102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next V6 02/14] bridge: Add vlan filtering
 infrastructure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 21 Jan 2013 11:45:46 -0000
To: vyasevic@redhat.com, bridge@lists.linux-foundation.org
Cc: mst@redhat.com, netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, shemminger@vyatta.com, davem@davemloft.net

Hi Vlad,

On Sun, 20 Jan 2013 20:50:59 -0500 Vlad Yasevich <vyasevic@redhat.com> wrote:
> On 01/20/2013 02:38 PM, Stephen Hemminger wrote:
> > Let's assume the people that really want this feature are using a lot
> > of vlan's. i.e n = 1000 or so. A bitmap is O(1). Any hash list would
> > incur a just a big memory penalty for the list head. In other words
> > a full bitmap is 4096 bits = 512 bytes.  If you use hash list,
> > then the equivalent memory size would be only 64 list heads, therefore
> > a bitmap is a better choice than a hlist.
> >
> 
> This was the approach taken in the RFC v1 of this series.  What I found 
> was that while it worked very well as far as speed goes, it was a bit 
> cumbersome to extend it to support pvids and it would completely fall
> on its face for egress policy that Shmulik is suggesting.  So any kinds 
> of extensions to it were tough to do.

I don't see why this is the case.

How about (sketch only, names questionable...):

struct net_bridge {
+	unsigned long vlan_port_membership_bitmap[VLAN_N_VID][PORT_BITMAP_LEN];
+	unsigned long vlan_port_egress_policy_bitmap[VLAN_N_VID][PORT_BITMAP_LEN];
}

(can be alloc'ed instead of the arrays being part of the struct)

struct net_bridge_port {
+	u16 pvid;
};

Allows O(1) to the query "is port P member of vlan V".
Allows O(1) to the query "should vlan V egress tagged/untagged on port P".

I guess this might simplify the data structures involved, avoiding the
refcounts, etc...

The penaties are:
 - memory
 - aesthetics (?)
 - inefficient if query is "give me the entire list of VLANs port P is
   member of". But do we have such a query in bridge's code?

You say it went cumbersome. Am I missing something?

BTW, altenatively, you may:

struct net_bridge_port {
+	unsigned long vlan_membership_bitmap[BITS_TO_LONGS(VLAN_N_VID)];
+	unsigned long vlan_egress_policy_bitmap[BITS_TO_LONGS(VLAN_N_VID)];
+	u16 pvid;
};

Which also allows O(1) to "is port 'nbp' member of vlan V".

Difference:
- For the membership structure:
  former (within net_bridge) uses 4096 * BR_MAX_PORTS bits,
  latter (within net_bridge_port) uses NumOfNBPs * 4096 bits 
- better aesthetics (?)

Regards,
Shmulik
