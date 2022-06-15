Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=81G8W5HZcsZGBz+5OMYMDedtIQ5UWl4XrEoXghNc1ZE=;
 b=WSsJPme3UHq4EYU7YhodN3CicGBI3v0oOn1cW+Quch7x+MGYPc3bXuJL0PHrLzOqJL
 iMEPA+pZLwol8Nqzs5Vq0uV4k7Mm45A+2iMrgdFHLjcrnEFO4+DV9FpyPAeHyvBhMSbH
 aINNLbd5xviC6a4ZCCm5w7AdXLPhwzF83Oku913g78TOLuLKqmMet24Luyvcnl+iPaVh
 DHT37bdC+uP1inQ2H1avWvoHRVM6qhd1x5Ch8JB9SeRo6Nb1OuCkfpR36napHiJEYrSW
 YYaYAD496PxAcBW1dv0/FV4rraUJKsu+roC4Ie40IgyGwk1/dkr3LJG0s10ZVD/xJoIJ
 B3YQ==
Message-ID: <eb011e1f-c264-eca6-8526-c0660a7e7844@blackwall.org>
Date: Wed, 15 Jun 2022 11:25:53 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220614063223.zvtrdrh7pbkv3b4v@wse-c0155>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220614063223.zvtrdrh7pbkv3b4v@wse-c0155>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: allow add/remove
 permanent mdb entries on disabled ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Casper Andersson <casper.casan@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Joachim Wiberg <troglobit@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

On 14/06/2022 09:32, Casper Andersson wrote:
> Adding mdb entries on disabled ports allows you to do setup before
> accepting any traffic, avoiding any time where the port is not in the
> multicast group.
> 
> Signed-off-by: Casper Andersson <casper.casan@gmail.com>
> ---
>  net/bridge/br_mdb.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Sounds and looks good to me. Ideally you should send a small selftest to
make sure this case is covered and someone won't break it in the future.

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



