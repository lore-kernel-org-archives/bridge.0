Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <5230B93B.3040900@cogentembedded.com>
Date: Wed, 11 Sep 2013 22:40:59 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1378745768-4495-1-git-send-email-cphealy@gmail.com>
In-Reply-To: <1378745768-4495-1-git-send-email-cphealy@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1] bridge: fix message_age_timer calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Chris Healy <cphealy@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, buytenh@wantstofly.org

Hello.

On 09/09/2013 08:56 PM, Chris Healy wrote:

> This changes the message_age_timer calculation to use the BPDU's max age as opposed to the local bridge's max age.  This is in accordance with section 8.6.2.3.2 Step 2 of the 802.1D-1998 sprecification.

    You should wrap your changelog lines at 80 chars at most, preferably less.

> With the current implementation, when running with very large bridge diameters, convergance will not always occur even if a root bridge is configured to have a longer max age.

> Tested successfully on bridge diameters of ~200.

> Signed-off-by: Chris Healy <cphealy@gmail.com>

WBR, Sergei

