Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D038D4103F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F1C340220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:user-agent:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=3LZxcQs9nOMkFoDos2+PgU3t6nZSk06DoiTQtWvijMk=;
 b=wUfdehM4WiupWRrJlT/Hxm6rzZgFZZSVUTcXcsGx5Z6aCq0BRBsQnvHtQValrPkRdT
 Ei0yruYzS+D2av84NoQ+xq3KPhNQLFH9vwI2nbpEj+6ndn1fpaL1Am6ctGiS89Ej1qis
 e6DyqA2NXmDUWlw9lwuHo3iSFGYQVZwsMlTzqJu5ZPnhLN5zK6qpxeWpokt5FE3QgOjB
 aBhMD3AwZ5OGOguAGSguB7t2z7JiQ/VYPt4Ff8IH3z6/olNS2rHzItkgR4PaUvXSkMl6
 xUjEY3/FgLD7k38wfk2c0FQKYUpqjd5cJD0tXbBxdv/gDXJbUIc6GoHuFUZXLwomcu3f
 MJGA==
Date: Thu, 07 Jul 2022 20:26:33 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220707171507.pojkwqhwqk5u6mmn@skbuf>
References: <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
 <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
 <86v8tu7za3.fsf@gmail.com>
 <4bf1c80d-0f18-f444-3005-59a45797bcfd@blackwall.org>
 <20220706181316.r5l5rzjysxow2j7l@skbuf>
 <7cf30a3e-a562-d582-4391-072a2c98ab05@blackwall.org>
 <20220706202130.ehzxnnqnduaq3rmt@skbuf>
 <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
 <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
 <20220707171507.pojkwqhwqk5u6mmn@skbuf>
Message-ID: <01FCBF77-AD39-4A0F-93AC-629E7269D950@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 7 July 2022 20:15:07 EEST, Vladimir Oltean <olteanv@gmail=2Ecom> wrote:
>Hi Nikolay,
>
>On Thu, Jul 07, 2022 at 05:08:15PM +0300, Nikolay Aleksandrov wrote:
>> On 07/07/2022 00:01, Nikolay Aleksandrov wrote:
>> > On 06/07/2022 23:21, Vladimir Oltean wrote:
>> >> On Wed, Jul 06, 2022 at 10:38:04PM +0300, Nikolay Aleksandrov wrote:
>> [snip]
>> > I already said it's ok to add hard configurable limits if they're don=
e properly performance-wise=2E
>> > Any distribution can choose to set some default limits after the opti=
on exists=2E
>> >=20
>>=20
>> Just fyi, and to avoid duplicate efforts, I already have patches for gl=
obal and per-port software
>> fdb limits that I'll polish and submit soon (depending on time availabi=
lity, of course)=2E If I find
>> more time I might add per-vlan limits as well to the set=2E They use em=
bedded netlink attributes
>> to config and dump, so we can easily extend them later (e=2Eg=2E differ=
ent action on limit hit, limit
>> statistics etc)=2E
>
>So again, to repeat myself, it's nice to have limits on FDB size, but
>those won't fix the software bridges that are now out in the open and
>can't have their configuration scripts changed=2E
>
>I haven't had the time to expand on this in a proper change yet, but I
>was thinking more along the lines of adding an OOM handler with
>register_oom_notifier() in br_fdb_init(), and on OOM, do something, like
>flush the FDB from all bridges=2E There are going to be complications, it
>will schedule switchdev, switchdev is going to allocate memory which
>we're low on, the workqueues aren't created with WQ_MEM_RECLAIM, so this
>isn't necessarily going to be a silver bullet either=2E But this is what
>concerns me the most, the unconfigured bridge killing the kernel so
>easily=2E As you can see, with an OOM handler I'm not so much trying to
>impose a fixed limit on FDB size, but do something sensible such that
>the bridge doesn't contribute to the kernel dying=2E

Hi Vladimir,
Sounds good to me, the fdb limits have come up multiple times in the past =
so I decided=20
to finally add them and build from there, with them configured oom shouldn=
't be hit=2E
These limits have never been present and people are fine (everyone deals w=
ith or leaves it), but I'll be happy to review and ack such changes=2E I ho=
pe you can correlate the oom and the bridge fdbs, not
just blindly flushing as that can be problematic if you plan to have it en=
abled by default=2E

Cheers,
  Nik
