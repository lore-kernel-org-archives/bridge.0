Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=HuDel8ayMwuZGcNVC/Xca01aagp05sJ/uzkjO6nmwrY=;
 b=MfmFVDcau+Ht5MC0Z11A0Lodc1upVa5x8ongdWS8TE8tjKiQLuzuK0pn8mBCNzIfSI
 qs5dNWnAfz2I+dUz6znusiGsfKJ7BDJMNJJqNHtjgPgDuOz/w6QTWaycta6RfSaj5fJd
 xRELdlQj1pSRQzr80J9k4mya1b6nFDdCC1Y7iw8GO8T31QuclJkAvIMX521fpn85ZBU9
 FZJOhHVQgXcQmfBRdZHxeYjK0v6CfHTqslJchOvJxdxdb8QzvGcT/6Rqkrmf2JcIGtd8
 Wk6mB9mSaA1A3L0d8p7I/YpIoBt259/YJdwN1q0JP7svIeqbfMiNa3IMTA8NHqiRtn/+
 U/cw==
References: <CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b9a61559-e7f7-86e9-6ac2-c988255db5f0@gmail.com>
Date: Tue, 10 Aug 2021 02:43:46 -0700
MIME-Version: 1.0
In-Reply-To: <CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge port isolation offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>



On 8/9/2021 9:40 PM, DENG Qingfang wrote:
> Hi,
> 
> Bridge port isolation flag (BR_ISOLATED) was added in commit
> 7d850abd5f4e. But switchdev does not offload it currently.
> It should be easy to implement in drivers, just like bridge offload
> but prevent isolated ports to communicate with each other.
> 
> Your thoughts?

It maps well on Broadcom switches but there was not a known use case 
AFAICT that warranted mapping this flag to program the switch hardware 
accordingly.
-- 
Florian
