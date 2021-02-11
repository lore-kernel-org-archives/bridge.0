Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WOudY93SgpXlwWt2mPFyzJ30b3FUMM1XmeZpD48+PWs=;
 b=gtmhq+gKxAIQwRoLueiyyM8KSz4zS74fz60WRnCzlmWBkOSNceC6LXR/Cp0Q8TGI1b
 ZcaEOxXCJIZSevyBzh7CUZvR2ctixi2PtczMc5b+WErQkPB5ZdsL9HTbl0NCRJZ9BoVM
 qMItqyj21CC6NlKcXy32PD8ORyArFEETL6/K9qAWfN9aupXIfgkOvehV2v3yy27jFIDn
 96JyFUUAQa5h6ZpFBn1RkwN2l8LhQvOFfWqyHmK79ChTuRMNBOJy9oe/1YiVoICmvO6c
 W5tN0SwmeS+oK462NWLtOlM2sOMiGOLoYmrMlGyJcAodpCQJDuIyv7aQmlcWbgkWN91H
 Ik9w==
References: <20210210091445.741269-1-olteanv@gmail.com>
 <20210210091445.741269-2-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <588cff67-699e-1971-a1a5-79d42f969f15@gmail.com>
Date: Wed, 10 Feb 2021 20:12:22 -0800
MIME-Version: 1.0
In-Reply-To: <20210210091445.741269-2-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 01/11] net: switchdev: propagate
 extack to port attributes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>



On 2/10/2021 1:14 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> When a struct switchdev_attr is notified through switchdev, there is no
> way to report informational messages, unlike for struct switchdev_obj.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
