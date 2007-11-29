Message-ID: <474EECA1.2090100@trash.net>
Date: Thu, 29 Nov 2007 17:45:21 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: [Bridge] BitTorrent still crashes Linux firewall running bridging
	:-(
References: <200711282000.lASK04sR013906@smtp2.linux-foundation.org>
	<8A55DBB97B4FBF4D9A6F23C92FE0F117EA45D6@BE08.exg3.exghost.com>
In-Reply-To: <8A55DBB97B4FBF4D9A6F23C92FE0F117EA45D6@BE08.exg3.exghost.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Libove <libove@felines.org>
Cc: bridge@lists.linux-foundation.org

Jay Libove wrote:
> Unfortunately, I did speak too soon, dammit. Even after replacing the
> Quad Tulip card with three independent Ethernet cards, BitTorrent
> (actually, Azureus) downloads are still regularly crashing this Linux
> firewall running bridging.
> 
> So, back to the drawing board. What's the next diagnostic step? I guess
> I could just kill the VoIP device for a day or two. Who needs home phone
> service, anyway? Oh, yeah, wait, my wife... So, next diagnostic steps,
> please?


Try capturing an oops using serial console or netconsole and post it.
