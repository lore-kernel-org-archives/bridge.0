Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=a1deU4EzeQc2joaO/0pAzd9yMJPMyBOx4cFep+UZqpU=;
 b=grrSiCZnED0iRJVv3x8DdKEd2SBdCYYEKvx78/W0bwwg6lNgPAwknPtj4c6HaqI+EB
 VZs4aVLKZIGpaopOl4oa9mXcGDZjPzf1yTo5p0EmoAYBo/s3qCpBLinPtdu3E6eGqBMb
 BeMNwzdrmDCinI9oocmQ5z5nhtlFXBeyLEDAN8X9j3/B9X7tOU2M4rO8llre/dB5Sq+1
 KlypWQFtEU1f3jxAFhUeICPh+WHp4WY2F4N17BPjz4AFxSx392cLPRuBgS1/6ir8D+5q
 pacdrxhFJUnthnPVsdra+8yLjOibVEBRoaxMPkokjOHAwNvP5aQuAOqkdbQulW94i2rb
 JeAg==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YjM7Iwx4MDdGEHFA@shredder>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
 <YjM7Iwx4MDdGEHFA@shredder>
Date: Thu, 17 Mar 2022 15:50:26 +0100
Message-ID: <86ilsciqfh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>, razor@blackwall.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On tor, mar 17, 2022 at 15:44, Ido Schimmel <idosch@idosch.org> wrote:
> On Thu, Mar 17, 2022 at 10:38:59AM +0100, Hans Schultz wrote:
>> Add an intermediate state for clients behind a locked port to allow for
>> possible opening of the port for said clients. This feature corresponds
>> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
>> latter defined by Cisco.
>> Only the kernel can set this FDB entry flag, while userspace can read
>> the flag and remove it by deleting the FDB entry.
>
> Can you explain where this flag is rejected by the kernel?
>
Is it an effort to set the flag from iproute2 on adding a fdb entry?

> Nik, it seems the bridge ignores 'NDA_FLAGS_EXT', but I think that for
> new flags we should do a better job and reject unsupported
> configurations. WDYT?
>
> The neighbour code will correctly reject the new flag due to
> 'NTF_EXT_MASK'.
