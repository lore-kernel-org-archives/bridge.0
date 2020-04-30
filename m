Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3RpLzR
 AZmoGsH5/njPn/0R69Z0vhJrHObhLFL6joNtg=; b=sbfh3p4t8AsArW+k8FG0o3
 da1kQbKW6t0TNVXhiq9T8xqMUTNAsJsFM36/B+fVsqhoCRc/qTC0pUUHhxMAzzi0
 HZs9xXNy56d0uSrW8GUewTiFeWO7Q9uwgiBsZv9e3YAfXKnmGaZotn6s+h6gI4w5
 efU5QKB2ModJQlXUM0xxXQaA1rSe/85yKr45f6q+EQ+S/CZS7RBuiQLRHkbkL8Bd
 RW+/BzWDgxUIyntFgoUCWrIvxytJ7x/LkX3S+wD9tmlk4LAJ3ONf7lHHb0ULQSHN
 YtdYG2IwdDGnuNjgD+bebRvntYbApo2axkATJXNQLld4J4kvBX4qCUb5vZMsx/rQ
 ==
Date: Thu, 30 Apr 2020 18:56:45 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20200430155645.GA4076599@splinter>
References: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
 <20200430105551.GA4068275@splinter>
 <4b3a6079-d8d4-24c5-8fc9-15bcb96bca80@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3a6079-d8d4-24c5-8fc9-15bcb96bca80@cumulusnetworks.com>
Subject: Re: [Bridge] BUG: soft lockup while deleting tap interface from
 vlan aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

On Thu, Apr 30, 2020 at 02:20:23PM +0300, Nikolay Aleksandrov wrote:
> Maybe we can batch the deletes at say 32 at a time?

Hi Nik,

Thanks for looking into this!

I don't really feel comfortable hard coding an arbitrary number of
entries before calling cond_resched(). I didn't see a noticeable
difference in execution time with the previous patch versus an unpatched
kernel. Also, in the examples I saw in the networking code
cond_resched() is always called after each loop iteration.

Let me know how you prefer it and I will send a patch.
