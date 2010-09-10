Date: Fri, 10 Sep 2010 08:11:28 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100910081128.0d582d9f@nehalam>
In-Reply-To: <AANLkTikWFR0xWPTALmVJz_Yt8J+2OCTXSHrE8syQH8pQ@mail.gmail.com>
References: <AANLkTikWFR0xWPTALmVJz_Yt8J+2OCTXSHrE8syQH8pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Port Security
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan Whelan <rcwhelan@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 10 Sep 2010 00:01:57 -0400
Ryan Whelan <rcwhelan@gmail.com> wrote:

> I am developing an appliance that will use bridging to create a little
> integrated switch.  We need to ensure that only approved devices are allowed
> to connect to the switch; are there any mechanisms to enforce security
> within the linux bridge? What would be the recommended method if not?
> ebtables?

no. it is not designed to do this.

> I did a search and found nothing- please point me in the right direction if
> I missed something!

802.1X?


-- 
