Return-Path: <f.cachereul@alphalink.fr>
Message-ID: <52E8E1B4.5030706@alphalink.fr>
Date: Wed, 29 Jan 2014 12:10:44 +0100
From: =?ISO-8859-1?Q?Fran=E7ois_Cachereul?= <f.cachereul@alphalink.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] bridge vlan: why packet have to be rejected if no vlan is
	configured
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I'm wondering why packets have to be rejected if vlan filtering is enabled =
and that no vlan is configured on a port.
I can't find any clue in the 802.1Q specification.

Regards,

Fran=E7ois
