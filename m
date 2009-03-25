MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090325.000643.55804624.davem@davemloft.net>
References: <1237539869-30721-1-git-send-email-leoli@freescale.com>
	<20090324.234051.60226102.davem@davemloft.net>
	<2a27d3730903250005w2e773b01x1e9ec0606fc0e3d4@mail.gmail.com>
	<20090325.000643.55804624.davem@davemloft.net>
Date: Wed, 25 Mar 2009 16:38:38 +0800
Message-ID: <2a27d3730903250138p447fcc17t33af99c709a29e13@mail.gmail.com>
From: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] net/bridge: use the maximum hard_header_len of
	ports for bridging device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Wed, Mar 25, 2009 at 3:06 PM, David Miller <davem@davemloft.net> wrote:
> From: Li Yang <leoli@freescale.com>
> Date: Wed, 25 Mar 2009 15:05:20 +0800
>
>> On Wed, Mar 25, 2009 at 2:40 PM, David Miller <davem@davemloft.net> wrot=
e:
>> > From: Li Yang <leoli@freescale.com>
>> > Date: Fri, 20 Mar 2009 17:04:29 +0800
>> >
>> >> The bridging device used a constant hard_header_len. =C2=A0This will =
cause
>> >> headroom shortage for ports with additional hardware header. =C2=A0Th=
e patch
>> >> makes bridging device to use the maximum value of all ports.
>> >>
>> >> Signed-off-by: Li Yang <leoli@freescale.com>
>> >
>> > Your driver must be able to cope with any amount of
>> > available headroom, no matter what hacks we put into
>> > the bridging layer.
>> >
>> > Please fix your driver, I'm not applying this patch.
>>
>> Ok. =C2=A0But it's not good to reallocate every packet generated locally=
.
>> Why not take this patch too?
>
> Because as Stephen showed it didn't handle all cases.
>
> Look at the patch I posted, that's the way to go.

Patch coming right away.  However I have some comment about your way.
The choice is yours.

- Leo
