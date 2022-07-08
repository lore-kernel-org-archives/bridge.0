Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 829898461C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60CF88461B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657242035;
 bh=70o+V3ET76drXM83rOdHEUsJuE2jU9gz82CTfzhNP0A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jkUoycSRQnG2Kh4/DvYw/ce+0v3+iNaW8HRBzoeSHYwm1RYucKZ+ua6u4dXGjwTlr
 N5QDKSvQp6sHnUky/qoZPZSc5HAOGW7dOQ1TomiH/VjTogx/SdP14x+HBv39VgFzqb
 /r0TSeUTNMUo3nM4JAOhRo8M0Pba0pt0p/CohpCNxX22CQKUk9qc7U06rC1ctRw63I
 tTyaoNhBA9FFU+KaMOM0TE7IKo2fZ7qMOSlMNLWPNM2feeVhgVZpkmFS+nEWr/bOKB
 7LArADuTVJJxzG+/4Cu/N6foNVlAKq4B5Il6lXh354DLiCM9OC0mdpPMnJ+b86s6qo
 HUsAIqvrKEphg==
Date: Thu, 7 Jul 2022 18:00:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220707180025.42cc41d8@kernel.org>
In-Reply-To: <20220707152930.1789437-1-netdev@kapio-technology.com>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 0/6] Extend locked port feature
 with FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu,  7 Jul 2022 17:29:24 +0200 Hans Schultz wrote:
>  [PATCH v4 net-next 0/6] Extend locked port feature with FDB locked flag (MAC-Auth/MAB)

Let's give it a day or two for feedback but the series does not apply
cleanly to net-next so a rebase & repost will be needed even if it's
otherwise perfect.
