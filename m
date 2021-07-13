Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NlVPTZqzkr7X/6SxfWdup8v6l5x7x3FOQrlL4P9RfQg=;
 b=ApkQ294WrZDrFMp44CboLatxYl0a2e1eN2N/HgtF8ZMgZxrKHelJMNQpByirmSEAHt
 /VZd8uL/gbvdnMCBGsbWr6euvFrlQbKKUM4OgFSdB6ZCaqfVq2MSNVdF9tHLddSFnNKj
 NZa3XQ4HwSQj/vcSlI6yMUHX/Q4H09d1tqupDQqCAEBgORcOpUZsGSWD1VUFUtbLNqiP
 zqS3S+Ac5eKdwSL8sqnNs3+8vb3fLDTIGp3bpo1Ea+8lH/EUc/3F6n7DaGs0/aCmV0wf
 zCocuPGt3uEOHiWPXzyHmz796Wp+ONQEzPOnQzdsmrMbvezQxqNkTFUtPKGobAeRtsTH
 a4uw==
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712152142.800651-4-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c4f3a25a-9dba-2710-490e-45e47ef56528@gmail.com>
Date: Mon, 12 Jul 2021 19:21:44 -0700
MIME-Version: 1.0
In-Reply-To: <20210712152142.800651-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v3 net-next 03/24] net: mlxsw: refactor
 prechangeupper sanity checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/12/2021 8:21 AM, Vladimir Oltean wrote:
> Make more room for extra code in the NETDEV_PRECHANGEUPPER handlers from
> mlxsw by moving the existing sanity checks to 2 new dedicated functions.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
