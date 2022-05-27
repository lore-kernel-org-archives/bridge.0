Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=2phuWBtcTkzKGfEFPcHjL5qNni//IzOpMEfDTaY87Dg=;
 b=a/6lEtQeNSwtgd+B0HQwGamPbSXYBak0YscNWlZH2/cUpwdbbAjCMlEDfXxPMCmOrv
 C+4+F0Z4eYHmr3iiuXdmt5mZ63JjkJlfLjAAAaciLrMQQRSxV9AHtoP3rSCsNUJtqdHI
 FlUW5jUaj6AUAs6lTwHCbeEbdjL+NbmODSkcWbukTJ6GMWwdAYtg5ZUaGIeoz8ADApXv
 scpsabiUuF162UFICurltoKqm8/0kcfzUpxxe/6aYV3VdvJGbK3o+EwnMdMVkv5Eq7yM
 TyFCOAZWRb4lDVyaDzF8Hhkfm70+iMyBVKw3U67S2GVj5jnyVIaeU++KAmPOT0wMrN0L
 RJwA==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YpCgxtJf9Qe7fTFd@shredder>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder>
Date: Fri, 27 May 2022 18:00:56 +0200
Message-ID: <86a6b33qyv.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

>
> As far as the bridge is concerned, locked entries are not really
> different from regular learned entries in terms of processing and since
> we don't have limits for regular entries I don't think we should have
> limits for locked entries.
>
> I do understand the problem you have in mv88e6xxx and I think it would
> be wise to hard code a reasonable limit there. It can be adjusted over
> time based on feedback and possibly exposed to user space.
>
> Just to give you another data point about how this works in other
> devices, I can say that at least in Spectrum this works a bit
> differently. Packets that ingress via a locked port and incur an FDB
> miss are trapped to the CPU where they should be injected into the Rx
> path so that the bridge will create the 'locked' FDB entry and notify it
> to user space. The packets are obviously rated limited as the CPU cannot
> handle billions of packets per second, unlike the ASIC. The limit is not
> per bridge port (or even per bridge), but instead global to the entire
> device.

Ahh, I see. I think that the best is for those FDB entries to be created
as dynamic entries, so that user-space does not have to keep track of
unauthorized entries.
Also the mv88e6xxx chipsets have a 'hold at one' feature, for authorized
entries, so that if a device goes quiet after being authorized the
driver can signal to the software bridge and further to userspace that
an authorized device has gone quiet, and the entry can then be
removed. This though requires user added dynamic entries in the ATU, or
you can call it synthetically 'learned' entries.
