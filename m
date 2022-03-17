Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Vhmaa8dvAWAF7hhtVerRMIY5hbJUzuvuMcKyuTSFTwg=;
 b=78YceMwTeAnCsJX1c/l4aRdsPn2rkY4Ej3QmSbpqhb5TZWTH8ViYLss/o47dggaWBB
 8Cq3ytvuEIm3eG0HwDRs1eZEPWddjcoQSsiuQ1izCrxzc14/dIVyxYGcBO23FMg961M8
 5H7Dv2ySLSpgGD0fkCQSc7e9IkkdujC3nrkcFu/UDWdlvDT0QVLM3lhK7NjIyRYqdqmJ
 b4asp0Vq7xwTU3ge/5S0G/gPuIMxk7pu1sxsNO2eF74epze+2Vrh1MVSX1q0d44mnJ82
 rPWQMfaUwUu8MHGhxMwvnnCiWq5QfEwA9QFjZ2Vtn+ZhtKxWnlY/r2N3LrGZOjaysGnt
 BhfQ==
Message-ID: <4e09ab7d-95eb-7114-97cd-1e389c948a9e@blackwall.org>
Date: Thu, 17 Mar 2022 11:01:20 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-9-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-9-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 08/15] net: bridge: mst: Add helper
 to check if MST is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 16/03/2022 17:08, Tobias Waldekranz wrote:
> This is useful for switchdev drivers that might want to refuse to join
> a bridge where MST is enabled, if the hardware can't support it.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/linux/if_bridge.h | 6 ++++++
>  net/bridge/br_mst.c       | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

