Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DF8341CB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7707341CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7q//eWD7kpKVjwkvP9sSwP1duHlI8w+YBBfIBpjcKsU=;
 b=XOWnbPeHK869eG5NgRyxRRIGBWXGJksAbHxR5YyTn4BIx6+j+VvSQiBjgC3IN9kLM6
 AIo37Y0Rc444kkJFPhPJ6euTVgyNThZCA2oJb2LzDS/1SVriuTTi8EvYecyC8eIdiBEA
 la8iyZFBSWntYG3t4RdeHYi2TDDpBZODccGCEEg9KztzkAhrwpRR4+oZ8vRrEH6hfG1I
 +R2LKV3N6AglJsS27FLGOe6VHMW4SFpYZRrG1BWdBlBxB0tdFUCbmlrjFalVdDQAPvUE
 UZjgytkW2zekKT3kN+TYRvzQJK4PsaCiyRzKlKREKYukuda1NuaZ59TM9s4yuM4laT8M
 VHYw==
Date: Fri, 27 Jan 2023 11:22:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230127092242.ajwlo3tivxsjsul7@skbuf>
References: <2919eb55e2e9b92265a3ba600afc8137a901ae5f.1674760340.git.leon@kernel.org>
 <20230126223213.riq6i2gdztwuinwi@skbuf> <Y9NfkgRbWAbrxQ1G@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9NfkgRbWAbrxQ1G@unreal>
Subject: Re: [Bridge] [PATCH net-next] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>

On Fri, Jan 27, 2023 at 07:22:26AM +0200, Leon Romanovsky wrote:
> It means changing ALL error unwind places where extack was forwarded
> before to subfunctions.
> 
> Places like this:
>  ret = func(..., extack)
>  if (ret) {
>    NL_SET_ERR_MSG_MOD...
>    return ret;
>  }
> 
> will need to be changed to something like this:
>  ret = func(..., extack)
>  if (ret) {
>    NL_SET_ERR_MSG_WEAK...
>    return ret;
>  }

Yeah, but my point is that you inspect the code that you plan to convert,
rather than converting it in bulk and inspecting later...

> Can we please discuss current code and not over-engineered case which
> doesn't exist in the reality?
> 
> Even for your case, I would like to see NL_SET_ERR_MSG_FORCE() to
> explicitly say that message will be overwritten.

__nla_validate_parse()

	if (unlikely(rem > 0)) {
		pr_warn_ratelimited("netlink: %d bytes leftover after parsing attributes in process `%s'.\n",
				    rem, current->comm);
		NL_SET_ERR_MSG(extack, "bytes leftover after parsing attributes");
		if (validate & NL_VALIDATE_TRAILING)
			return -EINVAL;
	}

	return 0;

called by nla_validate_deprecated() with validate == NL_VALIDATE_LIBERAL

followed by other extack setting in tunnel_key_copy_opts(), which will
not overwrite the initial warning message.
