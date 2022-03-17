Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cgLvCoZ+reMOUxcSz
 Tb0NcXr/MQseBQTzNT+xFvmncU=; b=hPKPfuHBJBEX+L4UQ2y043DZBPIh293rI
 doLU9LsgikXoL8Ib3ZEYa7L0VbDSUWgoXRHnUtNA0Qy4F27Yc3omfSGkvDItb/QN
 yK4/gBMjP9D0EFTMxsb0m1u/rowaRgVmRl1scbqYycJpn5AgYVIELxKQshjr6DHt
 BwXij39HpbqmZU4lxQBz4XWgDaQ3/lafgfFemTYAngvEIIJe6iS5NqnNPfehi+Xt
 JB/xy6oFqwEwd+zKcFSl9oM6W6pcCShLAmMcd9Wz1UabX155iPLgWP6AYJKGYQP5
 JU5d4z1vnokvLa/590Krvh8xlCYqP925JjCRXxNxkumgKWdihpecA==
Date: Thu, 17 Mar 2022 15:44:03 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YjM7Iwx4MDdGEHFA@shredder>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, razor@blackwall.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Mar 17, 2022 at 10:38:59AM +0100, Hans Schultz wrote:
> Add an intermediate state for clients behind a locked port to allow for
> possible opening of the port for said clients. This feature corresponds
> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
> latter defined by Cisco.
> Only the kernel can set this FDB entry flag, while userspace can read
> the flag and remove it by deleting the FDB entry.

Can you explain where this flag is rejected by the kernel?

Nik, it seems the bridge ignores 'NDA_FLAGS_EXT', but I think that for
new flags we should do a better job and reject unsupported
configurations. WDYT?

The neighbour code will correctly reject the new flag due to
'NTF_EXT_MASK'.
