Return-Path: <shmulik.ladkani@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	bh=ODdXZ84b2RrqvqcM1krK4korIPmDNQ+psFyPyk+Pop0=;
	b=AJoJQ3XWORgt8zd02IhCz2IVQoeV9XH8owEzhsJMykVWBejS5lEZ0aavPLw23G2D+G
	wBvsyBddhfjqrBsdM5FrBEpFEwnf2TVVKr3wbQOrRlQoVSf8Uu93DLFM7Vvcr6oyE+IR
	FunKT4EJDuHfBhmqKHQAQe5ekXxOIIRO4EKV+FGg+P4OgFjYy7stcgOJMChHc/iVD+bo
	kPjkgjqQIK/gB14OE5dJqqpgCW19B5ieAllPr+Ie/w/TfEof2Nz0gZGCutLAcToZZVs9
	p6z/TtdN7fEzXielkPxvADkJEMvvAn4vTOrQJNJGIizX8Vh9Cynuy7ga+8+qMpA+j/Zv
	er2w==
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <20130122175524.033c6f7f.shmulik.ladkani@gmail.com>
In-Reply-To: <50FEA2CF.4060406@redhat.com>
References: <1358360289-23249-1-git-send-email-vyasevic@redhat.com>
	<1358360289-23249-3-git-send-email-vyasevic@redhat.com>
	<CAHXqBFKg6Vp5=dprDYKON2LmshhX+nSPF7KRHiQmOS68PrQq-A@mail.gmail.com>
	<50FC307A.5090003@redhat.com>
	<20130120113825.759b4a58@nehalam.linuxnetplumber.net>
	<50FC9F03.5000102@redhat.com>
	<20130121134534.78032a54.shmulik.ladkani@gmail.com>
	<50FEA2CF.4060406@redhat.com>
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
Date: Tue, 22 Jan 2013 15:55:40 -0000
To: vyasevic@redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Stephen Hemminger <stephen@networkplumber.org>, shemminger@vyatta.com, davem@davemloft.net

Thanks Vlad,

On Tue, 22 Jan 2013 09:31:43 -0500 Vlad Yasevich <vyasevic@redhat.com> wrote:
> > I guess this might simplify the data structures involved, avoiding the
> > refcounts, etc...
> >
> > The penaties are:
> >   - memory
> >   - aesthetics (?)
> >   - inefficient if query is "give me the entire list of VLANs port P is
> >     member of". But do we have such a query in bridge's code?
> 
> Yes.  When a mac address is added to a port without an explicit vlan tag 
> we try to add it for every vlan available on the port.

I see.
Can't this be bypassed by adding a _single_ FDB entry whose VID value
denotes "member of ANY vlan" (value outside the valid 0-4095 range)?

> Also, in the API, the user may request vlans configured on a port.

Personally I'd pay the penalty implementing this specific user request
in an inefficeint way, to acheive overall simplicity in core bridge
code.
But that's just my humble opinion, maybe others might spot drawbacks
taking this approach.

BTW, went through the ML, couldn't find the reason why dropped the
per-port vlan bitmap and replaced with a vlan list (after your RFC v2
patches). Care to explain what was your motivation?

Regards,
Shmulik
