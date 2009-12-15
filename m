MIME-Version: 1.0
In-Reply-To: <001636025d9729a369047ac1127f@google.com>
References: <001636025d9729a369047ac1127f@google.com>
Date: Tue, 15 Dec 2009 10:28:29 -0600
Message-ID: <2e59e6970912150828r35af13c6r9e99be828a29576b@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Bridging partially (rx eth0 -> tx eth1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jhautbois@gmail.com
Cc: bridge@lists.linux-foundation.org

On Tue, Dec 15, 2009 at 3:32 AM,  <jhautbois@gmail.com> wrote:
> Hi there,
>
> I'm new on the mailing list, but this is not a good reason to be quiet :-).
> I'm very interested in the bridging functionnality of the Linux kernel.
> I am wondering f it is possible to bridge "partially".
>
> I mean : I would like to have all the traffic from the RX of my eth1 card
> directly sent out through the TX of my eth0 card.
> But I would like to receive the frames from the RX of eth0 thanks to a
> PF_PACKET socket.
>
> Is this possible with the bridging system ?
> I don't think so, but I haven't foud out the answer...

ebtables can select which traffic gets bridged.

>
> Thanks in advance !
> Best Regards.
> JM
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
