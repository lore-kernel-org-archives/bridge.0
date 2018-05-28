Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PJvydN0916C1vQLXGeOhKLyPZ966ZGl3vdgQOV8zeBw=;
	b=gH2nQ5zsMWlXDfnc0g1lLADpsyLeQbzAUPhm8rPqsYVvOTDxNrOFBJ0ibMUSU7US9b
	ytmCUmd9MIxH5Vdz4GXBjN000rQCslQ2+o5qkQ19UWhuZHfjU0yuZYhMFmUw9BWIR6dB
	3ipUfYAE5L6xu9VMPXHTg4tAwMyBX7aH9FOCtyD6uIx7e3PutRuNTwKGho5BNna2cKaS
	BtzKEZWLE1twqYdKoIhFmOV97M2T2u7JFUo0oeSrpmrqdzJy4SNDVQiXklzq2bjnwuy4
	WoKJc9MSX1KNsBmD0KMsn6xII5cKVYwGmP3G2UkF7MZ/+7cPGlzyYC977ant4QYq5RlE
	wrcg==
Date: Mon, 28 May 2018 10:42:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180528104253.64e10ffc@xeon-e3>
In-Reply-To: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
References: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Mon, 28 May 2018 17:44:16 +0200
Petr Machata <petrm@mellanox.com> wrote:

> Callers of br_fdb_find() need to hold the hash lock, which
> br_fdb_find_port() doesn't do. Add the missing lock/unlock
> pair.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  net/bridge/br_fdb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b19e310..3f5691a 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -135,9 +135,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>  		return NULL;
>  
>  	br = netdev_priv(br_dev);
> +	spin_lock_bh(&br->hash_lock);
>  	f = br_fdb_find(br, addr, vid);
>  	if (f && f->dst)
>  		dev = f->dst->dev;
> +	spin_unlock_bh(&br->hash_lock);
>  
>  	return dev;
>  }

Sigh. when did br_fdb_find start needing hash_lock?
What is the point of RCU then?
