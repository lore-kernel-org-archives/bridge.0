Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=d50SivsluZ6NgKs+usTsgrAsMJ0dcEpxRZNyKV1rSXs=;
 b=KEjqvKVgBn8GA2gtH494LAiAmb/ydkqhE0qixQQg7udNkBMreayccOL8QGT4+9jwAo
 t8kZxqgSZGtl09ng5HwGDPmcUrry5qYWoQjVCfjWq2U9abNeAOXw82YhtjH3SLyTERU+
 B/N0eFWNvI/SmJsWRZULqMzx8dgQrlM6Bo51fssmhbBIauoZtu3j8cZXvtsOpge73XXu
 tzpAH6CVtudOd4a3v8R0kMgO+jBiyzDf9eFQ693ZBSzocZJwyCE9hTjpmDZsc0qfC9eJ
 8/fP8fRmLPWGAkTswoDCLFgUX9xDlMKhAQOomAKqOWkV12euJV61I3dShddEfEn7HxoV
 qnIg==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <Yo+LAj1vnjq0p36q@shredder>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder>
Date: Fri, 27 May 2022 10:52:27 +0200
Message-ID: <86sfov2w8k.fsf@gmail.com>
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

On tor, maj 26, 2022 at 17:13, Ido Schimmel <idosch@idosch.org> wrote:
> On Tue, May 24, 2022 at 05:21:41PM +0200, Hans Schultz wrote:
>> Add an intermediate state for clients behind a locked port to allow for
>> possible opening of the port for said clients. This feature corresponds
>> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
>> latter defined by Cisco.
>> Locked FDB entries will be limited in number, so as to prevent DOS
>> attacks by spamming the port with random entries. The limit will be
>> a per port limit as it is a port based feature and that the port flushes
>> all FDB entries on link down.
>
> Why locked FDB entries need a special treatment compared to regular
> entries? A port that has learning enabled can be spammed with random
> source MACs just as well.
>
> The authorization daemon that is monitoring FDB notifications can have a
> policy to shut down a port if the rate / number of locked entries is
> above a given threshold.
>
> I don't think this kind of policy belongs in the kernel. If it resides
> in user space, then the threshold can be adjusted. Currently it's hard
> coded to 64 and I don't see how user space can change or monitor it.

In the Mac-Auth/MAB context, the locked port feature is really a form of
CPU based learning, and on mv88e6xxx switchcores, this is facilitated by
violation interrupts. Based on miss violation interrupts, the locked
entries are then added to a list with a timer to remove the entries
according to the bridge timeout.
As this is very CPU intensive compared to normal operation, the
assessment is that all this will jam up most devices if bombarded with
random entries at link speed, and my estimate is that any userspace 
daemon that listens to the ensuing fdb events will never get a chance
to stop this flood and eventually the device will lock down/reset. To
prevent this, the limit is introduced.

Ideally this limit could be adjustable from userspace, but in real
use-cases a cap like 64 should be more than enough, as that corresponds
to 64 possible devices behind a port that cannot authenticate by other
means (printers etc.) than having their mac addresses white-listed.

The software bridge behavior was then just set to correspond to the
offloaded behavior, but after correspondence with Nik, the software
bridge locked entries limit will be removed.
