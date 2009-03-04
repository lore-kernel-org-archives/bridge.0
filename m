MIME-Version: 1.0
Date: Wed, 4 Mar 2009 10:38:14 -0600
Message-ID: <d032bb9d0903040838p768a3b22p675047eb2fc7bbd4@mail.gmail.com>
From: Jason Ellison <infotek@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 802.11 bridge issue elaboration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org
Cc: shemminger@osdl.org, mrenzmann@compulan.de

Concerning 802.11 bridges,  the Net:Bridge FAQ states, "There are ways
to make it work, but it is not always straightforward and you probably
won't get it right without a pretty solid understanding of 802.11,
it's modes, and the frame header format."  Is there anyone who can
elaborate more on what "ways to make it work" there are?

http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wireless_card.21

It doesn't work with my Wireless card!
This is a known problem, and it is not caused by the bridge code. Many
wireless cards don't allow spoofing of the source address. It is a
firmware restriction with some chipsets. You might find some
information in the bridge mailing list archives to help. Has anyone
found a way to get around Wavelan not allowing anything but its own
MAC address? (answer by Michael Renzmann (mrenzmann at compulan.de))

Well, for 99% of computer users there will never be a way to get rid
of this. For this function a special firmware is needed. This firmware
can be loaded into the RAM of any WaveLAN card, so it could do its job
with bridging. But there is no documentation on the interface
available to the public. The only way to achieve this is to have a
full version of the hcf library which controls every function of the
card and also allows accessing the card's RAM. To get this full
version Lucent wants to know that it will be a financial win for them,
also you have to sign an NDA. So be sure that you won't most probably
get access to this peace of software until Lucent does not change its
mind in this (which I doubt never will happen).

If you urgently need to have a wireless LAN card which is able to
bridge, you should use one of those having the prism chipset onboard
(manufactured by Harris Intersil). There are drivers for those cards
available at www.linux-wlan.com (which is the website from Absoval),
and I found a mail that says that there is the necessary firmware and
an upload tool available for Linux to the public. If you need
additional features of an access point you should also talk to
Absoval.

I still don't understand!!
Doing full bridging of wireless (802.11) requires supporting WDS . The
current implementation doesn't do it.

It is possible to do limited wireless to Ethernet functionality with
some wireless drivers. This requires the device to be able to support
a different sender address and source address. That is what WDS
provides.

There are ways to make it work, but it is not always straightforward
and you probably won't get it right without a pretty solid
understanding of 802.11, it's modes, and the frame header format.

http://www.linuxfoundation.org/en/Net:Bridge#It_doesn.27t_work_with_my_Wireless_card.21
