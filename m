From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Mirroring an interface to an other by using bridge ?
Date: Mon, 29 Mar 2004 19:48:42 +0200
References: <000e01c4128b$8c13f9d0$7f619082@simba>
In-Reply-To: <000e01c4128b$8c13f9d0$7f619082@simba>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403291948.42235.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Rein van Koten <rein@vankoten.com>, bridge@osdl.org
Cc: shemminger@osdl.org

On Thursday 25 March 2004 18:06, Rein van Koten wrote:
> Hi,
> Anyway,
>
> I would appreciate your opinion on this or whether you know someone working
> along the same lines... I myself am not C savvy enough to rewrite the
> bridge module without additional input on this idea. And then again, maybe
> it already exists.

It should be simple, removing the following code from 
br_input.c::br_handle_frame_finish() should probably be enough:
	dst = br_fdb_get(br, dest);
	if (dst != NULL && dst->is_local) {
		if (!passedup)
			br_pass_frame_up(br, skb);
		else
			kfree_skb(skb);
		br_fdb_put(dst);
		goto out;
	}

	if (dst != NULL) {
		br_forward(dst->dst, skb);
		br_fdb_put(dst);
		goto out;
	}

It would probably be interesting to have a bridge userspace tool option so 
that the bridge acts like a hub, which is basically what you want.

cheers,
Bart

