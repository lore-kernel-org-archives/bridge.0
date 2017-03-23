Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=UmlzFc7kTuRgVh2/sr
	uIYdqAqCA8RUNiCkM93Jnalok=; b=lgF/8y1m5XTdBOJWZyP/Q03XyRCgFjL4gC
	odx69kXv9i8VR1AuzuVvYYnJdBUSP5qAan+kw/I+4Y9zduj6fZLTj9JX1P1IjDcO
	bVEV7ilNAYXfL9JQS/SMuKKm8U+kJTKOJwlRh42Z+Sh6p/8bKFcXOCPPf8w8N6Qq
	HPJjRhZ+xfyQe0nAWl0kjceZp27zktvII/wlx2dQirON56bN4nBEVM+03nJK7g+E
	CCebMOcsw46JPgoOq2zyDu7RgNci0ZWhlKi9OetjDn8Zy76X41PncFzVItSTc5F8
	754c0yFOVLWnAyBOQVEHLqr/nZlk02rt1cBnc7lwGduVcNWfDWeg==
Date: Thu, 23 Mar 2017 22:00:03 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20170323200002.GC25688@splinter.mtl.com>
References: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: allow user-space to
 add ext learned entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Thu, Mar 23, 2017 at 12:27:11PM +0200, Nikolay Aleksandrov wrote:
> Hi,
> This set adds the ability to add externally learned entries from
> user-space. For symmetry and proper function we need to allow SW entries
> to take over HW learned ones (similar to how HW can take over SW entries
> currently) which is needed for our use case (evpn) where we have pure SW
> ports and HW ports mixed in a single bridge. This does not play well with
> switchdev devices currently because there's no feedback when the entry is
> taken over, but this case has never worked anyway and feedback can be
> easily added when needed.

Yea, correct. I think we should handle FDB offload in a similar fashion
to route offload. FDBs aren't only of interest to the port to which they
point, but also to the other ports in the bridge. In your example use
case we would actually need to forward to the CPU packets that hit FDB
entries pointing to the SW ports. What would currently happen is that we
would simply flood such packets via the HW ports.
