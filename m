Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1653574406; x=1653660806; bh=vnwACNqhZoOoXwIiQWU2wL/gnnhq
 0onDp8LHcdhWTNg=; b=OuVZF/6dfxHAylAnDM80GjsVlw5t/W0/v3Ac/hSkZlW3
 6budAzqVou/8FMEF8bHQ3QdbUIZLRaBN6+Os28Hbm5QJzyZTQWOK6NHeuvozpG4X
 Dw6IKF742xWjTvOZGmrHJNkcQ4/nE8in2JOlJP4BZYDtYTde62kx6igeR8uCeLaw
 lqwvqMNvwbUWySqZ0dgh0eUEAl8kttTvhPlDv8Lms6Jmn8JNq/2E0/cIkjolRT16
 dzsbcLrSWh204ftIGEj/i3JiG2LTn1gJ60yBTGlDpbTwsAmMXpxVCzBa1AOlCDl0
 NrjltsJu1VRuvFQMfz7Z7AaD39FdaMLbY5wxNbs+Rw==
Date: Thu, 26 May 2022 17:13:22 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Yo+LAj1vnjq0p36q@shredder>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
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
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 05:21:41PM +0200, Hans Schultz wrote:
> Add an intermediate state for clients behind a locked port to allow for
> possible opening of the port for said clients. This feature corresponds
> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
> latter defined by Cisco.
> Locked FDB entries will be limited in number, so as to prevent DOS
> attacks by spamming the port with random entries. The limit will be
> a per port limit as it is a port based feature and that the port flushes
> all FDB entries on link down.

Why locked FDB entries need a special treatment compared to regular
entries? A port that has learning enabled can be spammed with random
source MACs just as well.

The authorization daemon that is monitoring FDB notifications can have a
policy to shut down a port if the rate / number of locked entries is
above a given threshold.

I don't think this kind of policy belongs in the kernel. If it resides
in user space, then the threshold can be adjusted. Currently it's hard
coded to 64 and I don't see how user space can change or monitor it.
