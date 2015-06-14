Return-Path: <stephen@networkplumber.org>
Date: Sun, 14 Jun 2015 10:49:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150614104939.65756b54@urahara>
In-Reply-To: <CAMT8_GOqHD0vQcsfrgLZaMiynbHXc-LijsWpjrtMR+S_Eofk9g@mail.gmail.com>
References: <CAMT8_GOqHD0vQcsfrgLZaMiynbHXc-LijsWpjrtMR+S_Eofk9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge created on centos6.4 running as a virtual
 machine over vmware does not work
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fahd Abbasi <fahd.abbasi@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 09 Jun 2015 23:18:46 +0000
Fahd Abbasi <fahd.abbasi@gmail.com> wrote:

> Hello,
> 
> I have centos running as a virtual machine using vmware on top of Windows 7.
> 
> Created a bridge which is up and learns the end Devices mac addresses as
> well.
> 
> However ping does not work.
> 
> Any ideas what can be the issue or any config guide for such a scenario?
> 
> Thanks,
> Fahd.

VMware switch does not allow guests to go into promicious mode.
