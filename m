MIME-Version: 1.0
In-Reply-To: <20100124092333.230aa8eb@opy.nosense.org>
References: <549992e51001230641n2e40d2co31573386e258a5cb@mail.gmail.com>
	<20100124092333.230aa8eb@opy.nosense.org>
Date: Sun, 24 Jan 2010 17:11:23 +0200
Message-ID: <549992e51001240711r3b7ad12ct6e44cc45ec442c43@mail.gmail.com>
From: Metuki Sabhe <sabhe.metuki@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] linux bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mark Smith <lk-netdev@lk-netdev.nosense.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hi Mark,

On Sun, Jan 24, 2010 at 12:53 AM, Mark Smith
<lk-netdev@lk-netdev.nosense.org> wrote:
> brctl setfd br0 0

yep, that was it! thanks! unfortunately for me i found the culprit
soon after I send the mail. should have sent earlier to save me hours
of debugging :)

thank you,
sabhe
