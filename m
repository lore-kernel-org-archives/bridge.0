From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Bridge Problem with RedHat and iptables
Date: Thu, 11 Nov 2004 17:02:35 +0100
References: <88240e9404111010486cfbd495@mail.gmail.com>
In-Reply-To: <88240e9404111010486cfbd495@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411111702.35282.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: TEJAS VORA <voratejas@gmail.com>, shemminger@osdl.org
Cc: bridge@lists.osdl.org

On Wednesday 10 November 2004 19:48, TEJAS VORA wrote:

Please use kernel 2.4.27 with this patch applied:
http://prdownloads.sourceforge.net/ebtables/ebtables-brnf-7_vs_2.4.27.diff.gz?download

I can't answer your first question, but the second question is easy to answer: 
you didn't apply the ebtables-brnf patch, and therefore iptables doesn't see 
bridged traffic.

