Date: Wed, 18 Jun 2008 07:33:54 +0200
From: Marek Kierdelewicz <marek@piasta.pl>
Message-ID: <20080618073354.371e7fbd@catlap>
In-Reply-To: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
References: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] kernel doesn't support  bridge with a ppp interface ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

>Hi list,

Hi,

>Is there a patch or way to do it if I want to make a kernel bridge with
>eth and ppp ports?

You can setup a tunnel with OpenVPN. You'd get a tap device on
both sides which can be bridged with eth.

Cheers,
Marek Kierdelewicz
