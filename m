Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0051C60DFC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5D31607F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=6Wj87YaxYO/pynZWsS9SuS5fRYRtHj/q6P5VHFbekcg=;
 b=hHKaBdrQ6fJzL+ZL80h+cgSUCPd7+qjDIzGZh8ZWXaChkI5ruA0hp/l+FutHmw9JoV
 W0Ju8bPTVp3GHKVT62HFG73xi017s5mw3lBMxF75N78qHcsgGQv2bqrAj2T5IZkuLRs0
 SiZRY1f2gYqNP7Bm0x86EyLaekNUeVbtUK7WX7p46lcGYODJTm7vzvtBgL8sILSDYoU7
 mTBcJDP4eDs4crZZH2zeDnE3W4M6D6uTY/KhJZv/S7ehDHhZMCAokUixesEVWtGT8mps
 F/BE/qrRiaHtdoRFoE4sXEQtWZG2GpR7A59NNr7EhzOE1LlCAOIYGddTa9T9qupo/uu8
 s3aw==
Message-ID: <c33c78f8-2be0-07bf-222b-9fae70f9ba32@blackwall.org>
Date: Mon, 4 Jul 2022 13:33:01 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220701144350.2034989-1-casper.casan@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220701144350.2034989-1-casper.casan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] selftest: net: bridge mdb add/del
 entry to port that is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Casper Andersson <casper.casan@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On 01/07/2022 17:43, Casper Andersson wrote:
> Tests that permanent mdb entries can be added/deleted on ports with state down.
> 
> Signed-off-by: Casper Andersson <casper.casan@gmail.com>
> ---
> This feature was implemented recently and a selftest was suggested:
> https://lore.kernel.org/netdev/20220614063223.zvtrdrh7pbkv3b4v@wse-c0155/
> 

Indeed, please CC the people who have suggested it and the bridge
maintainers next time. :)

That being said, thank you for the selftest!

Cheers,
 Nik


