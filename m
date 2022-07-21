Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A37DF40635
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB41940135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GmDGNOSJLQLxHyqUbqdShMpk7Rg5vZOsES1osVYWvM8=;
 b=OGZ65YDJOY1TZJZnVZ0xSIYu44FSqV/GtlogNPVbdgVP4qeyYrQHHb6ra08gEteLzV
 Xza04ZqfmXuFmhOG2yubswI7rJYU6kah1KAk/PdYFcxZyIUiqrdeuYQK7JWkTWahv2Xx
 H+xG3OpXRv+ZsZ9rhioXX7uv2G6nrzfmTw7N3N0qOk9X/x9PqACbHtBuZasvnja9gYYF
 XGFgOoVVvydCpOFf0ll9jxiG+6G7lDcfGhK5m+DOx0uPlszpt/Sur2fiK2z/QmWdmkHp
 l+f6Bq9/k/W8I3XbHk5jPjUEsVz3hHt6datdIR1dhSigpWSaon9VR/EFMeMQbgLyiwqu
 SAzA==
Date: Thu, 21 Jul 2022 14:51:16 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220721115116.5avmhghbmbbprq23@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Jul 08, 2022 at 11:50:33AM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-08 11:15, Vladimir Oltean wrote:
> > When the possibility for it to be true will exist, _all_ switchdev
> > drivers will need to be updated to ignore that (mlxsw, cpss, ocelot,
> > rocker, prestera, etc etc), not just DSA. And you don't need to
> > propagate the is_locked flag to all individual DSA sub-drivers when none
> > care about is_locked in the ADD_TO_DEVICE direction, you can just ignore
> > within DSA until needed otherwise.
> > 
> 
> Maybe I have it wrong, but I think that Ido requested me to send it to all
> the drivers, and have them ignore entries with is_locked=true ...

Yes, but re-read my message about what "all the drivers" means.
