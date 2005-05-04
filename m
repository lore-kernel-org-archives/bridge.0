Date: Wed, 4 May 2005 11:53:52 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Introducing latency
Message-ID: <20050504115352.2d046516@dxpl.pdx.osdl.net>
In-Reply-To: <EDF30175FE4D804B83444FB153172A50509A4D@louexch.KiZAN.net>
References: <EDF30175FE4D804B83444FB153172A50509A4D@louexch.KiZAN.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeff Gercken <JeffG@kizan.com>
Cc: bridge@lists.osdl.org

On Wed, 4 May 2005 14:07:46 -0400
"Jeff Gercken" <JeffG@kizan.com> wrote:

> Does anyone know how I might introduce latency on the packets that I
> bridge?  I'm trying to develop a system for simulating wan links and
> often bandwidth isn't as big an issue as delay, especially when talking
> wireless (dot11 or satellite).

You can use netem (part of recent 2.4 and 2.6 kernels).
More info at:
http://developer.osdl.org/shemminger/netem
